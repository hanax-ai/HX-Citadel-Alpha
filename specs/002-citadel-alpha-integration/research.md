# Research: Citadel Alpha HX Platform Integration

**Feature**: 002-citadel-alpha-integration
**Date**: 2025-10-15
**Status**: In Progress

## Research Questions

### 1. Ollama API Integration Patterns

**Question**: What is the best pattern for integrating with Ollama for embeddings and LLM inference?

**Findings**:

**Ollama Python Client** (ollama==0.4.8):
```python
import ollama

# Embeddings
response = ollama.embed(
    model="mxbai-embed-large",
    input="text to embed"
)
embeddings = response['embeddings']

# LLM Generation
response = ollama.generate(
    model="gemma3:27b",
    prompt="Your prompt here"
)
text = response['response']

# Streaming
for chunk in ollama.generate(model="gemma3:27b", prompt="...", stream=True):
    print(chunk['response'], end='')
```

**Decision**:
- Use official `ollama` Python client for simplicity
- Separate clients for embeddings (orchestrator) and LLM (ollama1)
- Implement retry logic with exponential backoff
- Use async client for non-blocking operations

**Alternatives Considered**:
- Direct HTTP requests to Ollama API: Rejected (reinventing the wheel)
- LangChain Ollama wrapper: Rejected (unnecessary dependency for simple use case)

**References**:
- Ollama Python Client: https://github.com/ollama/ollama-python
- Ollama API Docs: https://github.com/ollama/ollama/blob/main/docs/api.md

---

### 2. Qdrant Collection Schema Design

**Question**: How should we structure Qdrant collections for web crawl data?

**Findings**:

**Collection Schema**:
```python
from qdrant_client import QdrantClient
from qdrant_client.models import Distance, VectorParams, PointStruct

client = QdrantClient(url="https://hx-vectordb-server:6333")

# Create collection
client.create_collection(
    collection_name="citadel_alpha_crawls",
    vectors_config=VectorParams(
        size=1024,  # mxbai-embed-large dimension
        distance=Distance.COSINE
    )
)

# Insert point
client.upsert(
    collection_name="citadel_alpha_crawls",
    points=[
        PointStruct(
            id=uuid.uuid4().hex,
            vector=[...],  # 1024-dim embedding
            payload={
                "url": "https://example.com",
                "title": "Example Domain",
                "content": "...",
                "crawled_at": "2025-10-15T10:00:00Z",
                "chunk_index": 0,
                "model": "mxbai-embed-large"
            }
        )
    ]
)

# Search
results = client.search(
    collection_name="citadel_alpha_crawls",
    query_vector=[...],
    limit=5,
    score_threshold=0.7
)
```

**Decision**:
- Collection name: `citadel_alpha_crawls`
- Vector dimension: 1024 (mxbai-embed-large)
- Distance metric: Cosine similarity
- Payload: URL, title, content, metadata
- Use UUID for point IDs
- Chunk large documents for better retrieval

**Alternatives Considered**:
- Multiple collections by domain: Rejected (adds complexity, use payload filtering instead)
- Euclidean distance: Rejected (cosine better for text embeddings)
- Fixed IDs: Rejected (UUID prevents collisions)

**References**:
- Qdrant Python Client: https://python-client.qdrant.tech/
- Qdrant Collection Docs: https://qdrant.tech/documentation/concepts/collections/

---

### 3. Redis Caching Strategy

**Question**: How should we cache crawl results in Redis for performance?

**Findings**:

**Cache Key Pattern**:
```python
import redis
import hashlib
import json

r = redis.Redis.from_url("redis://hx-sqldb-server:6379")

# Generate cache key
def cache_key(url: str, options: dict) -> str:
    payload = json.dumps({"url": url, **options}, sort_keys=True)
    return f"crawl:{hashlib.sha256(payload.encode()).hexdigest()}"

# Set cache with TTL
r.setex(
    name=cache_key(url, options),
    time=3600,  # 1 hour TTL
    value=json.dumps(crawl_result)
)

# Get from cache
cached = r.get(cache_key(url, options))
if cached:
    return json.loads(cached)
```

**Decision**:
- Key pattern: `crawl:{sha256(url+options)}`
- Default TTL: 3600 seconds (1 hour)
- Store full crawl result as JSON
- Separate cache for embeddings: `embeddings:{sha256(content)}`
- Use Redis connection pooling

**Alternatives Considered**:
- Simple URL key: Rejected (doesn't account for different crawl options)
- No TTL: Rejected (unbounded cache growth)
- Pickle serialization: Rejected (JSON more portable, debuggable)

**Performance Impact**:
- Cache hit: ~5s response time (vs ~15s without cache)
- Cache hit rate target: >60% after warm-up

**References**:
- Redis Python Client: https://redis-py.readthedocs.io/
- Redis TTL: https://redis.io/commands/expire/

---

### 4. Open WebUI OpenAI-Compatible API

**Question**: What endpoints must we implement for Open WebUI integration?

**Findings**:

**Required Endpoints**:
```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# OpenAI-compatible chat completions
@app.post("/v1/chat/completions")
async def chat_completions(request: ChatCompletionRequest):
    return ChatCompletionResponse(
        id=f"chatcmpl-{uuid.uuid4()}",
        object="chat.completion",
        model="citadel-alpha",
        choices=[
            {
                "message": {
                    "role": "assistant",
                    "content": "..."
                },
                "finish_reason": "stop"
            }
        ]
    )

# Model listing
@app.get("/v1/models")
async def list_models():
    return {
        "data": [
            {"id": "citadel-alpha", "object": "model"}
        ]
    }
```

**Decision**:
- Implement minimal OpenAI-compatible API: `/v1/chat/completions`, `/v1/models`
- Parse user messages for crawl commands (e.g., "Crawl https://...")
- Return structured responses with crawl results
- Use streaming for long-running crawls (optional)

**Integration Pattern**:
- User sends chat message via Open WebUI
- Citadel Alpha parses message for URLs
- Executes crawl, stores in Qdrant
- Returns LLM-generated summary with sources

**Alternatives Considered**:
- Full OpenAI API implementation: Rejected (only need chat completions)
- Custom protocol: Rejected (Open WebUI expects OpenAI format)

**References**:
- OpenAI API Spec: https://platform.openai.com/docs/api-reference/chat
- Open WebUI Connection Docs: https://docs.openwebui.com/

---

### 5. Circuit Breaker Pattern for Service Failures

**Question**: How should we handle HX Platform service failures gracefully?

**Findings**:

**PyBreaker Library**:
```python
from pybreaker import CircuitBreaker

# Configure circuit breaker
ollama_breaker = CircuitBreaker(
    fail_max=5,          # Open after 5 failures
    timeout_duration=60,  # Try again after 60s
    name="ollama"
)

@ollama_breaker
def call_ollama_embeddings(text: str):
    return ollama.embed(model="mxbai-embed-large", input=text)

# Usage
try:
    embeddings = call_ollama_embeddings("text")
except CircuitBreakerError:
    # Fast-fail: Circuit open, don't waste time on failing service
    return fallback_response()
```

**Decision**:
- Use `pybreaker` library for circuit breaker pattern
- Separate circuit breakers for each HX Platform service
- Fast-fail when circuit open (<1ms vs 30s timeout)
- Health endpoint shows circuit breaker status
- Metrics: failure count, state (closed/open/half-open)

**Benefit**: Referenced from `/home/agent0/workspace/hx-citadel-ansible/CLAUDE.md`:
> Circuit breaker protection: PyBreaker integration on all orchestrator calls
> Fast-fail < 1ms (vs 30s timeout) - 10x performance improvement

**Alternatives Considered**:
- Manual retry logic: Rejected (circuit breaker handles state automatically)
- No failure handling: Rejected (cascade failures harm user experience)

**References**:
- PyBreaker: https://github.com/danielfm/pybreaker
- Circuit Breaker Pattern: https://martinfowler.com/bliki/CircuitBreaker.html
- HX Platform Implementation: `/home/agent0/workspace/hx-citadel-ansible/roles/fastmcp_server/`

---

### 6. Async I/O Best Practices with FastAPI

**Question**: How should we implement async endpoints for concurrent crawls?

**Findings**:

**FastAPI Async Pattern**:
```python
from fastapi import FastAPI, BackgroundTasks
import asyncio

app = FastAPI()

# Async endpoint
@app.post("/api/crawl")
async def crawl_endpoint(request: CrawlRequest, background_tasks: BackgroundTasks):
    job_id = uuid.uuid4().hex

    # Start crawl in background
    background_tasks.add_task(execute_crawl, job_id, request)

    return {"job_id": job_id, "status": "processing"}

# Async service layer
async def execute_crawl(job_id: str, request: CrawlRequest):
    async with aiohttp.ClientSession() as session:
        # Async operations
        content = await crawl_page(session, request.url)
        embeddings = await generate_embeddings_async(content)
        await store_in_qdrant_async(embeddings)
```

**Decision**:
- Use FastAPI `BackgroundTasks` for long-running crawls
- Async HTTP requests with `aiohttp` or `httpx`
- Job status tracking in Redis
- Support 5 concurrent crawls (semaphore limit)
- Async Ollama/Qdrant clients

**Benefits**:
- Non-blocking API responses (HTTP 202 pattern)
- Better resource utilization
- Scalable to multiple concurrent users

**Alternatives Considered**:
- Synchronous endpoints: Rejected (blocks server, poor UX)
- Celery task queue: Rejected (overkill for 5 concurrent crawls)

**References**:
- FastAPI Async: https://fastapi.tiangolo.com/async/
- FastAPI Background Tasks: https://fastapi.tiangolo.com/tutorial/background-tasks/

---

## Technology Comparisons

### Ollama vs OpenAI API

**Ollama (Chosen)**:
- ✅ No external API costs
- ✅ Low latency (local network)
- ✅ Data privacy (no external calls)
- ✅ HX Platform integration objective
- ❌ Requires infrastructure management

**OpenAI API (Rejected)**:
- ✅ High-quality models (GPT-4)
- ✅ No infrastructure needed
- ❌ API costs ($)
- ❌ Latency (internet)
- ❌ Data leaves network

**Decision**: Ollama for production, aligns with HX Platform goals.

---

### Qdrant vs ChromaDB

**Qdrant (Chosen)**:
- ✅ Distributed/scalable architecture
- ✅ Already deployed in HX Platform
- ✅ Advanced filtering capabilities
- ✅ Prometheus metrics
- ❌ More complex setup

**ChromaDB (Rejected)**:
- ✅ Simple embedded mode
- ✅ Used in original Crawl4AI
- ❌ Not HX Platform standard
- ❌ Scaling limitations

**Decision**: Qdrant for HX Platform integration and production readiness.

---

### FastAPI vs Streamlit

**FastAPI (Chosen)**:
- ✅ API-first design
- ✅ OpenAPI documentation
- ✅ Async support
- ✅ Open WebUI integration
- ✅ Production-ready
- ❌ No built-in UI

**Streamlit (Rejected)**:
- ✅ Quick UI development
- ✅ Used in original Crawl4AI
- ❌ Not API-first
- ❌ Limited async support
- ❌ Hard to integrate with Open WebUI

**Decision**: FastAPI for production API, Open WebUI provides UI.

---

## Implementation Patterns

### Configuration Management

**Pydantic Settings Pattern**:
```python
from pydantic_settings import BaseSettings
from pydantic import HttpUrl

class OllamaConfig(BaseSettings):
    embeddings_url: HttpUrl = "http://hx-orchestrator-server:11434"
    embeddings_model: str = "mxbai-embed-large"
    llm_url: HttpUrl = "http://hx-ollama1:11434"
    llm_model: str = "gemma3:27b"

    class Config:
        env_prefix = "OLLAMA_"
        env_file = ".env"

config = OllamaConfig()
```

**Benefits**:
- Type validation
- Environment variable support
- .env file support
- Clear error messages on misconfiguration

---

### Error Handling Strategy

**Layered Error Handling**:
1. **Service Layer**: Catch and log specific errors
2. **Circuit Breaker**: Fast-fail on repeated failures
3. **API Layer**: Return HTTP error codes with details
4. **Client**: Handle errors gracefully (fallback, retry)

**Example**:
```python
from fastapi import HTTPException

try:
    result = await crawl_service.crawl(url)
except ConnectionError as e:
    logger.error(f"Service unavailable: {e}")
    raise HTTPException(status_code=503, detail="Crawl service unavailable")
except ValidationError as e:
    raise HTTPException(status_code=400, detail=str(e))
```

---

## Open Questions

- [ ] **Q1**: Should we support multiple embedding models simultaneously?
  - **Current**: Single model (mxbai-embed-large)
  - **Option**: Allow model selection per request
  - **Decision Needed**: Review performance impact

- [ ] **Q2**: How to handle Playwright browser resource limits?
  - **Current**: 5 concurrent crawls (semaphore)
  - **Risk**: Browser processes consume memory
  - **Decision Needed**: Add max browser lifetime, restart policy

- [ ] **Q3**: Should we implement request authentication?
  - **Current**: API key via HX_API_KEY env var
  - **Option**: JWT tokens, OAuth
  - **Decision Needed**: Coordinate with Open WebUI auth strategy

---

## Next Steps

1. Complete Phase 1: Design & Contracts
2. Create OpenAPI contract files in `contracts/`
3. Write contract tests (failing)
4. Generate data-model.md with entity schemas
5. Update CLAUDE.md with integration patterns

---

**Status**: ✅ Core research complete - Ready for Phase 1 (Design)
**Open Questions**: 3 items requiring decision before implementation
