# Implementation Plan: Citadel Alpha HX Platform Integration

**Branch**: `002-citadel-alpha-integration` | **Date**: 2025-10-15 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/002-citadel-alpha-integration/spec.md`

## Summary

Create Citadel Alpha container - a production-ready modification of Crawl4AI Agent that replaces external dependencies (OpenAI API, ChromaDB, Streamlit) with HX Platform services (Ollama, Qdrant, Redis, FastAPI) for local deployment and Open WebUI integration.

## Technical Context

**Language/Version**: Python 3.11
**Primary Dependencies**: crawl4ai==0.6.2, playwright==1.52.0, fastapi==0.115.9, ollama==0.4.8, qdrant-client==1.12.1, redis==5.2.1
**Storage**: Qdrant (hx-vectordb-server:6333), Redis cache (hx-sqldb-server:6379)
**Testing**: pytest, pytest-asyncio, httpx for API testing
**Target Platform**: Docker container on Ubuntu 24.04 (hx-test-server), integrated with HX Platform
**Project Type**: Single container with FastAPI service
**Performance Goals**: Crawl <30s, embeddings <10s, query <5s (cached) / <15s (uncached), 5 concurrent crawls
**Constraints**: Requires HX Platform services running, port 11236 available, hx-platform Docker network
**Scale/Scope**: Multi-user API service, production deployment, Open WebUI integration

## Constitution Check

✅ **TDD Required**: Contract tests and integration tests before implementation
✅ **Spec-Driven Development**: spec.md completed with comprehensive API contracts
✅ **Container-First**: Docker container with HX Platform integration
✅ **HX Platform Integration**: Primary objective - Ollama, Qdrant, Redis, Open WebUI
✅ **API-First Design**: FastAPI with OpenAI-compatible endpoints

**No Constitution violations** - This follows spec-driven TDD workflow with HX Platform integration.

## Project Structure

### Documentation (this feature)
```
specs/002-citadel-alpha-integration/
├── spec.md              # Feature specification (complete)
├── plan.md              # This file
├── research.md          # HX Platform service integration patterns
├── contracts/           # OpenAPI specs for all endpoints
│   ├── health.yaml      # Health and integration status endpoints
│   ├── crawl.yaml       # Crawl job endpoints
│   ├── collections.yaml # Qdrant collection management
│   ├── query.yaml       # Vector search and LLM query
│   └── openai.yaml      # OpenAI-compatible endpoints for Open WebUI
└── tasks.md             # Implementation tasks (TDD workflow)
```

### Source Code (repository)
```
containers/citadel-alpha/
├── src/
│   ├── config/
│   │   ├── __init__.py
│   │   ├── hx_platform.py      # HX Platform service configuration
│   │   ├── ollama.py           # Ollama client config (embeddings + LLM)
│   │   ├── qdrant.py           # Qdrant client config
│   │   └── redis.py            # Redis client config
│   ├── services/
│   │   ├── __init__.py
│   │   ├── crawl_service.py    # Core crawling logic (Playwright)
│   │   ├── embedding_service.py # Ollama embeddings integration
│   │   ├── llm_service.py      # Ollama LLM integration
│   │   ├── vector_service.py   # Qdrant vector operations
│   │   └── cache_service.py    # Redis caching
│   ├── api/
│   │   ├── __init__.py
│   │   ├── main.py             # FastAPI application
│   │   ├── routes/
│   │   │   ├── __init__.py
│   │   │   ├── health.py       # Health endpoints
│   │   │   ├── crawl.py        # Crawl endpoints
│   │   │   ├── collections.py  # Collection management
│   │   │   ├── query.py        # Query endpoints
│   │   │   └── openai.py       # OpenAI-compatible endpoints
│   │   └── models/
│   │       ├── __init__.py
│   │       ├── requests.py     # Pydantic request models
│   │       └── responses.py    # Pydantic response models
│   └── utils/
│       ├── __init__.py
│       ├── monitoring.py       # Health checks, metrics
│       └── logging.py          # Structured logging
├── tests/
│   ├── contract/               # Contract tests (API schemas)
│   │   ├── test_health_contract.py
│   │   ├── test_crawl_contract.py
│   │   ├── test_collections_contract.py
│   │   ├── test_query_contract.py
│   │   └── test_openai_contract.py
│   ├── integration/            # Integration tests (HX Platform)
│   │   ├── test_ollama_embeddings.py
│   │   ├── test_ollama_llm.py
│   │   ├── test_qdrant_storage.py
│   │   ├── test_redis_cache.py
│   │   └── test_end_to_end_crawl.py
│   └── unit/                   # Unit tests
│       ├── test_config.py
│       ├── test_crawl_service.py
│       └── test_cache_service.py
├── Dockerfile                  # FastAPI + Playwright
├── docker-compose.yml          # Port 11236, HX Platform network
├── requirements.txt            # Python dependencies (no OpenAI/ChromaDB)
├── .env.example                # HX Platform endpoints
└── README.md                   # Integration documentation
```

**Structure Decision**: Single container with FastAPI service architecture. Modular design with separate config, services, API routes, and models for testability and maintainability.

## Phase 0: Outline & Research

**Research Tasks**:
1. Ollama API patterns for embeddings and LLM inference
2. Qdrant collection schema design for web crawl data
3. Redis caching strategies for crawl results
4. Open WebUI OpenAI-compatible API requirements
5. Circuit breaker patterns for service failures
6. Async I/O best practices with FastAPI

**Output**: research.md with HX Platform integration patterns and best practices

## Phase 1: Design & Contracts

**Activities**:

1. **Create OpenAPI Contracts** (`contracts/` directory):
   - `health.yaml` - GET /health, GET /health/integrations
   - `crawl.yaml` - POST /api/crawl, GET /api/crawl/{job_id}
   - `collections.yaml` - GET/POST/DELETE /api/collections
   - `query.yaml` - POST /api/query
   - `openai.yaml` - POST /v1/chat/completions

2. **Design Data Models** (`data-model.md`):
   - CrawlRequest, CrawlResponse, CrawlJob entities
   - QdrantDocument schema (vectors + metadata)
   - RedisCache key patterns and TTL strategy
   - HealthStatus, IntegrationStatus entities

3. **Generate Contract Tests**:
   - One test file per contract (tests/contract/)
   - Assert request/response schemas match OpenAPI
   - Tests must FAIL (no implementation yet)

4. **Create Integration Test Scenarios**:
   - End-to-end crawl with Ollama embeddings
   - Vector storage and similarity search
   - Cache hit/miss scenarios
   - Open WebUI chat flow

5. **Update CLAUDE.md** with:
   - HX Platform service endpoints and patterns
   - Common commands for testing integration
   - Troubleshooting guide for service connectivity

**Output**: contracts/*, data-model.md, failing contract tests, CLAUDE.md updates

## Phase 2: Task Planning Approach

**Task Generation Strategy**:
- **Setup**: Project structure, dependencies, linting, HX Platform client initialization
- **Tests First (TDD)**:
  - Contract tests for all 5 API contract files [P]
  - Integration tests for each HX Platform service [P]
  - End-to-end test scenarios
- **Core Implementation**:
  - Configuration modules (config/)
  - Service layer (services/)
  - API routes (api/routes/)
  - Pydantic models (api/models/)
- **Integration**: Wire services together, error handling, logging
- **Polish**: Performance optimization, documentation, comparison testing

**Ordering Strategy**:
1. TDD order: All tests before any implementation
2. Dependency order: Config → Services → API routes
3. Mark [P] for parallel execution (different files, no dependencies)
4. Integration tests validate HX Platform connectivity

**Estimated Output**: 40-50 numbered, ordered tasks in tasks.md

**Test Coverage Target**: >80% for production readiness

## Phase 3+: Future Implementation

**Phase 3**: Generate tasks.md with complete TDD workflow
**Phase 4**: Implementation following tasks.md
**Phase 5**: Validation:
  - All tests passing
  - HX Platform integration verified
  - Open WebUI connection working
  - Performance benchmarks met
  - Comparison with original Crawl4AI Agent (functional parity)

## Complexity Tracking

| Aspect | Complexity | Justification |
|--------|-----------|---------------|
| **Multiple HX Platform Services** | 4 services (Ollama x2, Qdrant, Redis) | Required for production HX Platform integration; simpler approach (single service) rejected because it defeats the purpose of platform integration |
| **OpenAI-Compatible API** | Custom implementation for Open WebUI | Required for Open WebUI integration; using standard OpenAI client library rejected because we need local Ollama backend |
| **Async I/O** | FastAPI async endpoints | Required for performance (5 concurrent crawls); synchronous approach rejected due to performance constraints |

**Simpler Alternatives Considered and Rejected**:
- Use OpenAI API directly: Rejected (cost, latency, defeats HX Platform purpose)
- Use ChromaDB instead of Qdrant: Rejected (not integrating with HX Platform)
- Skip Redis caching: Rejected (performance requirement: <5s cached queries)
- Keep Streamlit: Rejected (Open WebUI integration requirement)

## Progress Tracking

**Phase Status**:
- [ ] Phase 0: Research (HX Platform integration patterns)
- [ ] Phase 1: Design (contracts, data models, tests)
- [ ] Phase 2: Task planning (describe approach only)
- [ ] Phase 3: Tasks generated
- [ ] Phase 4: Implementation
- [ ] Phase 5: Validation

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [ ] Post-Design Constitution Check: PASS (pending Phase 1)
- [ ] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented (see Complexity Tracking)

**Dependencies**:
- **Prerequisite**: Spec 001 (Crawl4AI validation) must be complete for baseline comparison
- **Infrastructure**: HX Platform services must be running (Ollama, Qdrant, Redis)
- **Network**: hx-platform Docker network must exist

---
*Based on HX-Citadel-Alpha CONSTITUTION.md and HX Platform Architecture v3.0*
