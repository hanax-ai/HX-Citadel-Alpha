#!/bin/bash
# Create GitHub issues for Spec 002: Citadel Alpha HX Platform Integration (90 tasks)
# This script is large - it creates all 90 issues for the production implementation

set -e

REPO="hanax-ai/HX-Citadel-Alpha"
MILESTONE="Spec 002: Citadel Alpha HX Platform Integration"

echo "Creating issues for Spec 002 in $REPO..."
echo "This will create 90 issues - please be patient..."

# Helper function to create issue
create_issue() {
  local title="$1"
  local body="$2"
  local labels="$3"

  gh issue create \
    --repo $REPO \
    --title "$title" \
    --body "$body" \
    --label "$labels" \
    --milestone "$MILESTONE"

  echo "Created: $title"
}

# Phase 3.1: Setup (5 tasks)
echo "Creating Phase 3.1: Setup tasks..."

create_issue "T001: Create project structure" \
"Create complete project structure for Citadel Alpha

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.1 Setup

**Directories to create**:
\`\`\`bash
mkdir -p containers/citadel-alpha/src/{config,services,api/{routes,models},utils}
mkdir -p containers/citadel-alpha/tests/{contract,integration,unit}
\`\`\`

**Acceptance Criteria**:
- [ ] All directories created
- [ ] \_\_init\_\_.py files in all Python packages
- [ ] Structure matches plan.md" \
"spec:002,phase:setup,type:task,priority:critical,parallel"

create_issue "T002: Initialize Python project with dependencies" \
"Initialize Python project with dependencies from requirements.txt

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.1 Setup

**Command**:
\`\`\`bash
cd containers/citadel-alpha
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
\`\`\`

**Acceptance Criteria**:
- [ ] Virtual environment created
- [ ] All dependencies installed successfully
- [ ] No version conflicts" \
"spec:002,phase:setup,type:task,priority:high"

create_issue "T003: Configure pytest and testing tools" \
"Configure pytest, pytest-asyncio, pytest-cov in pytest.ini

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.1 Setup
**File**: \`containers/citadel-alpha/pytest.ini\`

**Acceptance Criteria**:
- [ ] pytest.ini created with asyncio configuration
- [ ] Coverage settings configured (>80% target)
- [ ] Test discovery patterns set" \
"spec:002,phase:setup,type:task,priority:medium,parallel"

create_issue "T004: Configure linting tools" \
"Configure linting tools: ruff, mypy, black in pyproject.toml

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.1 Setup
**File**: \`containers/citadel-alpha/pyproject.toml\`

**Acceptance Criteria**:
- [ ] Ruff configuration (Python 3.11, line length 120)
- [ ] Mypy strict mode configured
- [ ] Black formatter settings
- [ ] All tools tested and working" \
"spec:002,phase:setup,type:task,priority:medium,parallel"

create_issue "T005: Create base logging configuration" \
"Create base logging configuration in src/utils/logging.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.1 Setup
**File**: \`containers/citadel-alpha/src/utils/logging.py\`

**Acceptance Criteria**:
- [ ] Structured logging with JSON format
- [ ] Correlation ID support
- [ ] Log levels configurable via env vars
- [ ] Module tested" \
"spec:002,phase:setup,type:task,priority:medium,parallel"

# Phase 3.2: Tests First (TDD) - Contract Tests
echo "Creating Phase 3.2: Contract Tests (10 tasks)..."

create_issue "T006: Contract test GET /health" \
"**TDD**: Contract test GET /health endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_health_contract.py\`

**Test Requirements**:
- [ ] Assert GET /health returns 200
- [ ] Validate response schema (status, timestamp, version)
- [ ] Test MUST FAIL initially (no implementation)

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] OpenAPI schema compliance checked" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel"

create_issue "T007: Contract test GET /health/integrations" \
"**TDD**: Contract test GET /health/integrations endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_health_contract.py\`

**Test Requirements**:
- [ ] Assert GET /health/integrations returns 200
- [ ] Validate response schema (ollama_embeddings, ollama_llm, qdrant, redis status)
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] All HX Platform services checked in schema" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel"

create_issue "T008: Contract test POST /api/crawl" \
"**TDD**: Contract test POST /api/crawl endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_crawl_contract.py\`

**Test Requirements**:
- [ ] Assert POST /api/crawl accepts CrawlRequest
- [ ] Returns 202 Accepted with job_id
- [ ] Validate request/response schemas
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] HTTP 202 async pattern validated" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel"

create_issue "T009: Contract test GET /api/crawl/{job_id}" \
"**TDD**: Contract test GET /api/crawl/{job_id} endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_crawl_contract.py\`

**Test Requirements**:
- [ ] Assert GET /api/crawl/{job_id} returns job status
- [ ] Validate CrawlResponse schema
- [ ] Handle status: processing, completed, failed
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] All status codes validated" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel"

create_issue "T010: Contract test GET /api/collections" \
"**TDD**: Contract test GET /api/collections endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_collections_contract.py\`

**Test Requirements**:
- [ ] Assert GET /api/collections returns collection list
- [ ] Validate collection schema (name, vectors_count, points_count)
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Qdrant collection schema validated" \
"spec:002,phase:tests,type:test,tdd-gate,priority:high,parallel"

create_issue "T011: Contract test POST /api/collections" \
"**TDD**: Contract test POST /api/collections endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_collections_contract.py\`

**Test Requirements**:
- [ ] Assert POST /api/collections creates collection
- [ ] Returns 201 Created
- [ ] Validate CollectionRequest/Response schemas
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Collection creation contract defined" \
"spec:002,phase:tests,type:test,tdd-gate,priority:high,parallel"

create_issue "T012: Contract test DELETE /api/collections/{name}" \
"**TDD**: Contract test DELETE /api/collections/{name} endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_collections_contract.py\`

**Test Requirements**:
- [ ] Assert DELETE /api/collections/{name} deletes collection
- [ ] Returns 204 No Content
- [ ] Handle 404 for non-existent collections
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Deletion contract defined" \
"spec:002,phase:tests,type:test,tdd-gate,priority:high,parallel"

create_issue "T013: Contract test POST /api/query" \
"**TDD**: Contract test POST /api/query endpoint

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_query_contract.py\`

**Test Requirements**:
- [ ] Assert POST /api/query accepts QueryRequest
- [ ] Returns QueryResponse with results + LLM response
- [ ] Validate RAG response schema
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] RAG query contract validated" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel"

create_issue "T014: Contract test POST /v1/chat/completions" \
"**TDD**: Contract test POST /v1/chat/completions (OpenAI-compatible)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_openai_contract.py\`

**Test Requirements**:
- [ ] Assert POST /v1/chat/completions accepts ChatCompletionRequest
- [ ] Returns OpenAI-compatible ChatCompletionResponse
- [ ] Validate message format (role, content)
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] OpenAI API compatibility validated" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel,hx-platform"

create_issue "T015: Contract test GET /v1/models" \
"**TDD**: Contract test GET /v1/models (OpenAI-compatible)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/contract/test_openai_contract.py\`

**Test Requirements**:
- [ ] Assert GET /v1/models returns model list
- [ ] Validate OpenAI model list schema
- [ ] Include 'citadel-alpha' model
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Model listing contract defined" \
"spec:002,phase:tests,type:test,tdd-gate,priority:high,parallel"

# Phase 3.2: Tests First (TDD) - Integration Tests
echo "Creating Phase 3.2: Integration Tests (6 tasks)..."

create_issue "T016: Integration test Ollama embeddings connection" \
"**TDD**: Integration test Ollama embeddings connection

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/integration/test_ollama_embeddings.py\`

**Test Requirements**:
- [ ] Connect to hx-orchestrator-server:11434
- [ ] Generate embeddings with mxbai-embed-large
- [ ] Validate embedding dimensions (1024)
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] HX Platform service integration tested" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel,hx-platform"

create_issue "T017: Integration test Ollama LLM generation" \
"**TDD**: Integration test Ollama LLM generation

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/integration/test_ollama_llm.py\`

**Test Requirements**:
- [ ] Connect to hx-ollama1:11434
- [ ] Generate text with gemma3:27b
- [ ] Validate response format
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] LLM integration tested" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel,hx-platform"

create_issue "T018: Integration test Qdrant collection create/delete" \
"**TDD**: Integration test Qdrant collection create/delete

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/integration/test_qdrant_storage.py\`

**Test Requirements**:
- [ ] Connect to hx-vectordb-server:6333
- [ ] Create test collection
- [ ] Delete test collection
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Qdrant integration tested" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel,hx-platform"

create_issue "T019: Integration test Qdrant vector upsert/search" \
"**TDD**: Integration test Qdrant vector upsert/search

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/integration/test_qdrant_storage.py\`

**Test Requirements**:
- [ ] Upsert test vectors to Qdrant
- [ ] Search with similarity threshold
- [ ] Validate results and scores
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Vector operations tested" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,parallel,hx-platform"

create_issue "T020: Integration test Redis cache set/get" \
"**TDD**: Integration test Redis cache set/get

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/integration/test_redis_cache.py\`

**Test Requirements**:
- [ ] Connect to hx-sqldb-server:6379
- [ ] Set value with TTL
- [ ] Get value and verify
- [ ] Test expiration
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Redis caching tested" \
"spec:002,phase:tests,type:test,tdd-gate,priority:high,parallel,hx-platform"

create_issue "T021: Integration test end-to-end crawl workflow" \
"**TDD**: Integration test end-to-end crawl workflow

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)
**File**: \`containers/citadel-alpha/tests/integration/test_end_to_end_crawl.py\`

**Test Requirements**:
- [ ] Crawl test URL
- [ ] Generate embeddings via Ollama
- [ ] Store in Qdrant
- [ ] Cache in Redis
- [ ] Query with LLM
- [ ] Test MUST FAIL initially

**Acceptance Criteria**:
- [ ] Test written and failing
- [ ] Full workflow integration tested" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical,hx-platform"

# TDD Gate
echo "Creating TDD Gate task..."

create_issue "T022: TDD GATE - Verify all tests fail" \
"**TDD GATE**: Run pytest and confirm all 21 tests fail (no implementation yet)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.2 Tests First (TDD)

**Command**:
\`\`\`bash
cd containers/citadel-alpha
pytest tests/contract/ tests/integration/ -v
\`\`\`

**Expected**: All 21 tests FAIL (10 contract + 6 integration + end-to-end)

**CRITICAL**: Phase 3.3 implementation is BLOCKED until this gate passes

**Acceptance Criteria**:
- [ ] All contract tests failing (10/10)
- [ ] All integration tests failing (6/6)
- [ ] Failure reasons documented
- [ ] Ready to proceed with implementation" \
"spec:002,phase:tests,type:test,tdd-gate,priority:critical"

# Phase 3.3: Core Implementation - Configuration
echo "Creating Phase 3.3: Configuration Layer (4 tasks)..."

create_issue "T023: HX Platform configuration module" \
"Implement HX Platform configuration in src/config/hx_platform.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/config/hx_platform.py\`

**Requirements**:
- [ ] Pydantic settings for all HX Platform services
- [ ] Environment variable support
- [ ] Validation on startup
- [ ] Type hints throughout

**Acceptance Criteria**:
- [ ] Module created with HXPlatformConfig class
- [ ] All service URLs configurable
- [ ] Tests passing (contract tests should start passing)" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T024: Ollama client configuration" \
"Implement Ollama client configuration in src/config/ollama.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/config/ollama.py\`

**Requirements**:
- [ ] OllamaConfig with embeddings and LLM URLs
- [ ] Model name configuration
- [ ] Connection pooling setup
- [ ] Type hints

**Acceptance Criteria**:
- [ ] Module created with OllamaConfig class
- [ ] Separate configs for embeddings and LLM
- [ ] Tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T025: Qdrant client configuration" \
"Implement Qdrant client configuration in src/config/qdrant.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/config/qdrant.py\`

**Requirements**:
- [ ] QdrantConfig with URL and collection settings
- [ ] API key support (if needed)
- [ ] Vector dimension configuration (1024)
- [ ] Type hints

**Acceptance Criteria**:
- [ ] Module created with QdrantConfig class
- [ ] Collection schema configurable
- [ ] Tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T026: Redis client configuration" \
"Implement Redis client configuration in src/config/redis.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/config/redis.py\`

**Requirements**:
- [ ] RedisConfig with connection URL
- [ ] TTL configuration
- [ ] Password support
- [ ] Type hints

**Acceptance Criteria**:
- [ ] Module created with RedisConfig class
- [ ] Connection pooling configured
- [ ] Tests passing" \
"spec:002,phase:implementation,type:task,priority:high,parallel,hx-platform"

# Phase 3.3: Core Implementation - Services
echo "Creating Phase 3.3: Service Layer (5 tasks)..."

create_issue "T027: Crawl service with Playwright" \
"Implement crawl service with Playwright in src/services/crawl_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/services/crawl_service.py\`

**Requirements**:
- [ ] CrawlService class with async methods
- [ ] Playwright browser management
- [ ] Content extraction and chunking
- [ ] Metadata extraction
- [ ] Error handling

**Acceptance Criteria**:
- [ ] Service implemented with type hints
- [ ] Async/await pattern
- [ ] Tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel"

create_issue "T028: Embedding service with Ollama" \
"Implement embedding service with Ollama in src/services/embedding_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/services/embedding_service.py\`

**Requirements**:
- [ ] EmbeddingService class
- [ ] Ollama client integration (hx-orchestrator-server)
- [ ] Batch processing support
- [ ] Error handling with fallback models

**Acceptance Criteria**:
- [ ] Service implemented
- [ ] 1024-dim embeddings generated
- [ ] Integration tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T029: LLM service with Ollama" \
"Implement LLM service with Ollama in src/services/llm_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/services/llm_service.py\`

**Requirements**:
- [ ] LLMService class
- [ ] Ollama client integration (hx-ollama1)
- [ ] Prompt templates for RAG
- [ ] Streaming support (optional)

**Acceptance Criteria**:
- [ ] Service implemented
- [ ] gemma3:27b integration working
- [ ] Integration tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T030: Vector service with Qdrant" \
"Implement vector service with Qdrant in src/services/vector_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/services/vector_service.py\`

**Requirements**:
- [ ] VectorService class
- [ ] Qdrant client integration
- [ ] Collection management (create, delete, list)
- [ ] Vector operations (upsert, search)
- [ ] Similarity search with threshold

**Acceptance Criteria**:
- [ ] Service implemented
- [ ] Qdrant integration working
- [ ] Integration tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T031: Cache service with Redis" \
"Implement cache service with Redis in src/services/cache_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/services/cache_service.py\`

**Requirements**:
- [ ] CacheService class
- [ ] Redis client integration
- [ ] Cache key generation (hash URL + options)
- [ ] TTL management (default 3600s)
- [ ] Cache invalidation

**Acceptance Criteria**:
- [ ] Service implemented
- [ ] Redis caching working
- [ ] Integration tests passing" \
"spec:002,phase:implementation,type:task,priority:high,parallel,hx-platform"

# Phase 3.3: Core Implementation - API Models
echo "Creating Phase 3.3: API Models (2 tasks)..."

create_issue "T032: Pydantic request models" \
"Implement Pydantic request models in src/api/models/requests.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/models/requests.py\`

**Models to implement**:
- [ ] CrawlRequest (url, max_depth, extract_embeddings, etc.)
- [ ] QueryRequest (query, collection, limit, threshold)
- [ ] CollectionRequest (name, vector_size, distance)
- [ ] ChatCompletionRequest (OpenAI-compatible)

**Acceptance Criteria**:
- [ ] All request models implemented
- [ ] Validation rules applied
- [ ] Type hints complete" \
"spec:002,phase:implementation,type:task,priority:critical,parallel"

create_issue "T033: Pydantic response models" \
"Implement Pydantic response models in src/api/models/responses.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/models/responses.py\`

**Models to implement**:
- [ ] CrawlResponse (job_id, status, url, content, etc.)
- [ ] QueryResponse (results, llm_response, sources)
- [ ] HealthResponse (status, timestamp, version)
- [ ] IntegrationStatus (service statuses)
- [ ] ChatCompletionResponse (OpenAI-compatible)

**Acceptance Criteria**:
- [ ] All response models implemented
- [ ] Schema validation complete
- [ ] Type hints complete" \
"spec:002,phase:implementation,type:task,priority:critical,parallel"

# Phase 3.3: Core Implementation - API Routes
echo "Creating Phase 3.3: API Routes (5 tasks)..."

create_issue "T034: Health endpoints implementation" \
"Implement health endpoints in src/api/routes/health.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/routes/health.py\`

**Endpoints**:
- [ ] GET /health - Basic health check
- [ ] GET /health/integrations - HX Platform service status

**Acceptance Criteria**:
- [ ] Both endpoints implemented
- [ ] Service status checks working
- [ ] Contract tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T035: Crawl endpoints implementation" \
"Implement crawl endpoints in src/api/routes/crawl.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/routes/crawl.py\`

**Endpoints**:
- [ ] POST /api/crawl - Submit crawl job (HTTP 202)
- [ ] GET /api/crawl/{job_id} - Get crawl status/results

**Acceptance Criteria**:
- [ ] Async job pattern implemented
- [ ] Job tracking in Redis
- [ ] Contract tests passing" \
"spec:002,phase:implementation,type:task,priority:critical"

create_issue "T036: Collections endpoints implementation" \
"Implement collections endpoints in src/api/routes/collections.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/routes/collections.py\`

**Endpoints**:
- [ ] GET /api/collections - List Qdrant collections
- [ ] POST /api/collections - Create collection
- [ ] DELETE /api/collections/{name} - Delete collection

**Acceptance Criteria**:
- [ ] All CRUD operations implemented
- [ ] Qdrant integration working
- [ ] Contract tests passing" \
"spec:002,phase:implementation,type:task,priority:high,parallel,hx-platform"

create_issue "T037: Query endpoints implementation" \
"Implement query endpoints in src/api/routes/query.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/routes/query.py\`

**Endpoints**:
- [ ] POST /api/query - RAG query with vector search + LLM

**Acceptance Criteria**:
- [ ] Vector similarity search working
- [ ] LLM integration for RAG
- [ ] Citations included
- [ ] Contract tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,parallel,hx-platform"

create_issue "T038: OpenAI-compatible endpoints implementation" \
"Implement OpenAI-compatible endpoints in src/api/routes/openai.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/routes/openai.py\`

**Endpoints**:
- [ ] POST /v1/chat/completions - OpenAI chat API
- [ ] GET /v1/models - Model listing

**Acceptance Criteria**:
- [ ] OpenAI API compatibility verified
- [ ] Open WebUI integration pattern
- [ ] Contract tests passing" \
"spec:002,phase:implementation,type:task,priority:critical,hx-platform"

# Phase 3.3: Core Implementation - FastAPI App
echo "Creating Phase 3.3: FastAPI Application (3 tasks)..."

create_issue "T039: FastAPI app initialization" \
"Initialize FastAPI application in src/api/main.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/main.py\`

**Requirements**:
- [ ] Create FastAPI app instance
- [ ] Configure OpenAPI documentation
- [ ] Add startup/shutdown events
- [ ] Initialize HX Platform clients

**Acceptance Criteria**:
- [ ] App starts successfully
- [ ] OpenAPI docs at /docs
- [ ] Health checks working" \
"spec:002,phase:implementation,type:task,priority:critical"

create_issue "T040: Register all API routes" \
"Register all API routes in src/api/main.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/main.py\`

**Routes to register**:
- [ ] Health routes (/, /health, /health/integrations)
- [ ] Crawl routes (/api/crawl)
- [ ] Collections routes (/api/collections)
- [ ] Query routes (/api/query)
- [ ] OpenAI routes (/v1/*)

**Acceptance Criteria**:
- [ ] All routes registered
- [ ] Route prefixes correct
- [ ] OpenAPI docs show all endpoints" \
"spec:002,phase:implementation,type:task,priority:critical"

create_issue "T041: Add CORS middleware and error handlers" \
"Add CORS middleware and error handlers in src/api/main.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.3 Core Implementation
**File**: \`containers/citadel-alpha/src/api/main.py\`

**Requirements**:
- [ ] CORS middleware for Open WebUI
- [ ] Global exception handlers
- [ ] Request validation error handlers
- [ ] Logging middleware

**Acceptance Criteria**:
- [ ] CORS configured correctly
- [ ] Errors return proper JSON responses
- [ ] Request logging working" \
"spec:002,phase:implementation,type:task,priority:high"

# Phase 3.4: Integration
echo "Creating Phase 3.4: Integration (8 tasks)..."

create_issue "T042: Wire crawl service to embedding service" \
"Wire crawl service to embedding service (content → embeddings)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Crawl service calls embedding service after content extraction
- [ ] Batch processing for multiple chunks
- [ ] Error handling for embedding failures

**Acceptance Criteria**:
- [ ] Integration working end-to-end
- [ ] Embeddings generated for crawled content
- [ ] Tests passing" \
"spec:002,phase:integration,type:task,priority:critical,hx-platform"

create_issue "T043: Wire crawl service to vector service" \
"Wire crawl service to vector service (embeddings → Qdrant)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Store embeddings in Qdrant after generation
- [ ] Metadata storage (URL, title, timestamp)
- [ ] Error handling for Qdrant failures

**Acceptance Criteria**:
- [ ] Integration working
- [ ] Embeddings stored in Qdrant
- [ ] Tests passing" \
"spec:002,phase:integration,type:task,priority:critical,hx-platform"

create_issue "T044: Wire crawl service to cache service" \
"Wire crawl service to cache service (check cache before crawl, store after)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Check Redis cache before starting crawl
- [ ] Return cached result if available
- [ ] Store result in cache after successful crawl
- [ ] Cache invalidation logic

**Acceptance Criteria**:
- [ ] Cache hit/miss working
- [ ] Performance improvement measured
- [ ] Tests passing" \
"spec:002,phase:integration,type:task,priority:high,hx-platform"

create_issue "T045: Wire query service to LLM service" \
"Wire query service to LLM service (RAG: retrieve chunks → LLM summary)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Vector similarity search retrieves relevant chunks
- [ ] Chunks passed to LLM as context
- [ ] LLM generates summary with citations
- [ ] Error handling for LLM failures

**Acceptance Criteria**:
- [ ] RAG workflow complete
- [ ] Citations include source URLs
- [ ] Tests passing" \
"spec:002,phase:integration,type:task,priority:critical,hx-platform"

create_issue "T046: Add circuit breaker pattern with PyBreaker" \
"Add circuit breaker pattern using PyBreaker for all HX Platform calls

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Services to protect**:
- [ ] Ollama embeddings calls
- [ ] Ollama LLM calls
- [ ] Qdrant calls
- [ ] Redis calls (optional - can degrade gracefully)

**Configuration**:
- fail_max: 5
- timeout_duration: 60s

**Acceptance Criteria**:
- [ ] Circuit breakers implemented
- [ ] Fast-fail <1ms when circuit open
- [ ] Health endpoint shows circuit states
- [ ] Tests passing" \
"spec:002,phase:integration,type:task,priority:high,hx-platform"

create_issue "T047: Implement structured logging with correlation IDs" \
"Implement structured logging with correlation IDs

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Generate correlation ID per request
- [ ] Include in all log messages
- [ ] JSON-formatted logs
- [ ] Log levels configurable

**Acceptance Criteria**:
- [ ] Logging working across all modules
- [ ] Correlation IDs traceable
- [ ] Log output validated" \
"spec:002,phase:integration,type:task,priority:medium"

create_issue "T048: Add health monitoring with service status checks" \
"Add health monitoring with service status checks

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Health check for each HX Platform service
- [ ] Latency measurement per service
- [ ] Circuit breaker state in health response
- [ ] Cache hit rate metrics

**Acceptance Criteria**:
- [ ] /health/integrations returns all service statuses
- [ ] Latency metrics included
- [ ] Health checks performant (<100ms total)" \
"spec:002,phase:integration,type:task,priority:high,hx-platform"

create_issue "T049: Implement async job status tracking in Redis" \
"Implement async job status tracking in Redis

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.4 Integration

**Requirements**:
- [ ] Store job status in Redis (processing, completed, failed)
- [ ] Update status throughout crawl workflow
- [ ] TTL for job status (e.g., 24 hours)
- [ ] Query endpoint retrieves status

**Acceptance Criteria**:
- [ ] Job tracking working
- [ ] Status updates in real-time
- [ ] Tests passing" \
"spec:002,phase:integration,type:task,priority:high,hx-platform"

# Continue in next part due to length...
echo ""
echo "Created first 49 issues for Spec 002"
echo "Run script 05-create-issues-spec002-part2.sh to create remaining 41 issues"
