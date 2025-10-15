# Tasks: Citadel Alpha HX Platform Integration

**Input**: Design documents from `/specs/002-citadel-alpha-integration/`
**Prerequisites**: plan.md (complete), research.md (complete), spec 001 validation (complete)

## Phase 3.1: Setup

- [ ] T001 Create project structure: `src/config/`, `src/services/`, `src/api/routes/`, `src/api/models/`, `src/utils/`, `tests/contract/`, `tests/integration/`, `tests/unit/`
- [ ] T002 Initialize Python project with dependencies from requirements.txt
- [ ] T003 [P] Configure pytest, pytest-asyncio, pytest-cov in `pytest.ini`
- [ ] T004 [P] Configure linting tools: ruff, mypy, black in `pyproject.toml`
- [ ] T005 [P] Create base logging configuration in `src/utils/logging.py`

## Phase 3.2: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.3

**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

### Contract Tests (OpenAPI Schema Validation)

- [ ] T006 [P] Contract test GET /health in `tests/contract/test_health_contract.py`
- [ ] T007 [P] Contract test GET /health/integrations in `tests/contract/test_health_contract.py`
- [ ] T008 [P] Contract test POST /api/crawl in `tests/contract/test_crawl_contract.py`
- [ ] T009 [P] Contract test GET /api/crawl/{job_id} in `tests/contract/test_crawl_contract.py`
- [ ] T010 [P] Contract test GET /api/collections in `tests/contract/test_collections_contract.py`
- [ ] T011 [P] Contract test POST /api/collections in `tests/contract/test_collections_contract.py`
- [ ] T012 [P] Contract test DELETE /api/collections/{name} in `tests/contract/test_collections_contract.py`
- [ ] T013 [P] Contract test POST /api/query in `tests/contract/test_query_contract.py`
- [ ] T014 [P] Contract test POST /v1/chat/completions in `tests/contract/test_openai_contract.py`
- [ ] T015 [P] Contract test GET /v1/models in `tests/contract/test_openai_contract.py`

### Integration Tests (HX Platform Services)

- [ ] T016 [P] Integration test Ollama embeddings connection in `tests/integration/test_ollama_embeddings.py`
- [ ] T017 [P] Integration test Ollama LLM generation in `tests/integration/test_ollama_llm.py`
- [ ] T018 [P] Integration test Qdrant collection create/delete in `tests/integration/test_qdrant_storage.py`
- [ ] T019 [P] Integration test Qdrant vector upsert/search in `tests/integration/test_qdrant_storage.py`
- [ ] T020 [P] Integration test Redis cache set/get in `tests/integration/test_redis_cache.py`
- [ ] T021 [P] Integration test end-to-end crawl workflow in `tests/integration/test_end_to_end_crawl.py`

### Verify All Tests Fail

- [ ] T022 Run pytest and confirm all 21 tests fail (no implementation yet)

## Phase 3.3: Core Implementation (ONLY after tests are failing)

### Configuration Layer

- [ ] T023 [P] HX Platform configuration in `src/config/hx_platform.py`
- [ ] T024 [P] Ollama client configuration in `src/config/ollama.py`
- [ ] T025 [P] Qdrant client configuration in `src/config/qdrant.py`
- [ ] T026 [P] Redis client configuration in `src/config/redis.py`

### Service Layer

- [ ] T027 [P] Crawl service with Playwright in `src/services/crawl_service.py`
- [ ] T028 [P] Embedding service with Ollama in `src/services/embedding_service.py`
- [ ] T029 [P] LLM service with Ollama in `src/services/llm_service.py`
- [ ] T030 [P] Vector service with Qdrant in `src/services/vector_service.py`
- [ ] T031 [P] Cache service with Redis in `src/services/cache_service.py`

### API Models (Pydantic)

- [ ] T032 [P] Request models in `src/api/models/requests.py` (CrawlRequest, QueryRequest, CollectionRequest, ChatCompletionRequest)
- [ ] T033 [P] Response models in `src/api/models/responses.py` (CrawlResponse, QueryResponse, HealthResponse, ChatCompletionResponse)

### API Routes

- [ ] T034 [P] Health endpoints in `src/api/routes/health.py` (GET /health, GET /health/integrations)
- [ ] T035 Crawl endpoints in `src/api/routes/crawl.py` (POST /api/crawl, GET /api/crawl/{job_id})
- [ ] T036 [P] Collections endpoints in `src/api/routes/collections.py` (GET/POST/DELETE /api/collections)
- [ ] T037 [P] Query endpoints in `src/api/routes/query.py` (POST /api/query)
- [ ] T038 OpenAI-compatible endpoints in `src/api/routes/openai.py` (POST /v1/chat/completions, GET /v1/models)

### FastAPI Application

- [ ] T039 FastAPI app initialization in `src/api/main.py`
- [ ] T040 Register all routes in `src/api/main.py`
- [ ] T041 Add CORS middleware and error handlers in `src/api/main.py`

## Phase 3.4: Integration

- [ ] T042 Wire crawl service to embedding service (content → embeddings)
- [ ] T043 Wire crawl service to vector service (embeddings → Qdrant)
- [ ] T044 Wire crawl service to cache service (check cache before crawl, store after)
- [ ] T045 Wire query service to LLM service (RAG: retrieve chunks → LLM summary)
- [ ] T046 Add circuit breaker pattern using pybreaker for all HX Platform calls
- [ ] T047 Implement structured logging with correlation IDs
- [ ] T048 Add health monitoring with service status checks
- [ ] T049 Implement async job status tracking in Redis

## Phase 3.5: Polish

### Unit Tests

- [ ] T050 [P] Unit tests for configuration loading in `tests/unit/test_config.py`
- [ ] T051 [P] Unit tests for crawl service in `tests/unit/test_crawl_service.py`
- [ ] T052 [P] Unit tests for cache service in `tests/unit/test_cache_service.py`

### Performance & Validation

- [ ] T053 Performance test: Concurrent crawls (5 simultaneous) meet <30s target
- [ ] T054 Performance test: Embedding generation <10s per page
- [ ] T055 Performance test: Cached query response <5s
- [ ] T056 Performance test: Uncached query response <15s

### Documentation

- [ ] T057 [P] Update README.md with API usage examples
- [ ] T058 [P] Update CLAUDE.md with HX Platform integration patterns
- [ ] T059 [P] Create API documentation using FastAPI OpenAPI autogeneration

### Cleanup

- [ ] T060 Remove code duplication (DRY refactoring)
- [ ] T061 Run linting tools (ruff, mypy, black) and fix all issues
- [ ] T062 Verify test coverage >80% using pytest-cov

## Phase 3.6: Deployment & Validation

- [ ] T063 Build Citadel Alpha container locally: `docker-compose build`
- [ ] T064 Test container health locally before deployment
- [ ] T065 Verify HX Platform services reachable from container
- [ ] T066 Run Ansible pre-flight checks: `ansible-playbook ... --check`
- [ ] T067 Deploy to hx-test-server: `ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-citadel-alpha.yml`
- [ ] T068 Verify container running: `docker ps | grep citadel-alpha`
- [ ] T069 Check container logs for errors: `docker logs citadel-alpha`
- [ ] T070 Verify health endpoint: `curl http://hx-test-server:11236/health`
- [ ] T071 Verify integration status: `curl http://hx-test-server:11236/health/integrations | jq`

## Phase 3.7: Open WebUI Integration

- [ ] T072 Configure Open WebUI connection to http://hx-test-server:11236/v1
- [ ] T073 Test chat message: "Crawl https://example.com and summarize"
- [ ] T074 Verify crawl executes and LLM response includes summary
- [ ] T075 Verify Qdrant stores embeddings (check collection in UI)
- [ ] T076 Test follow-up query: "What was the main topic?"
- [ ] T077 Verify RAG retrieval uses cached/stored data

## Phase 3.8: Comparison Testing (vs Original Crawl4AI Agent)

- [ ] T078 Run same URL crawl in both containers (original 11235, citadel 11236)
- [ ] T079 Compare content extraction (same text extracted?)
- [ ] T080 Compare embedding quality (similar vector distributions?)
- [ ] T081 Compare query relevance (same chunks retrieved?)
- [ ] T082 Document functional parity in `specs/002-citadel-alpha-integration/comparison-report.md`

## Phase 3.9: Final Validation

- [ ] T083 Run full test suite: `pytest tests/ -v --cov=src --cov-report=html`
- [ ] T084 Verify all contract tests passing (21/21)
- [ ] T085 Verify all integration tests passing
- [ ] T086 Verify all unit tests passing
- [ ] T087 Verify test coverage >80%
- [ ] T088 Create validation report in `specs/002-citadel-alpha-integration/validation-report.md`
- [ ] T089 Mark spec.md acceptance criteria as passed/failed
- [ ] T090 Document production readiness assessment

## Dependencies

**Phase 3.1 (Setup)**:
- T001-T005 can run in parallel (different files, independent operations)

**Phase 3.2 (Tests - TDD Critical)**:
- T006-T015: Contract tests can run in parallel (different files)
- T016-T021: Integration tests can run in parallel (different services)
- T022 depends on T006-T021 (verify all tests fail)
- **GATE**: Phase 3.3 blocked until T022 confirms all tests failing

**Phase 3.3 (Implementation)**:
- T023-T026: Config modules can run in parallel (different files)
- T027-T031: Service modules can run in parallel (different files)
- T032-T033: Model files can run in parallel (different files)
- T034, T036-T038: Route files can run in parallel (different files)
- T035 sequential (may depend on T034 patterns)
- T039-T041 sequential (FastAPI app wiring)

**Phase 3.4 (Integration)**:
- T042-T049 sequential (wiring services together)

**Phase 3.5 (Polish)**:
- T050-T052 can run in parallel (unit tests, different files)
- T053-T056 sequential (performance tests build on each other)
- T057-T059 can run in parallel (documentation, different files)
- T060-T062 sequential (cleanup after all implementation done)

**Phase 3.6 (Deployment)**:
- T063-T071 sequential (deployment steps)

**Phase 3.7 (Open WebUI)**:
- T072-T077 sequential (integration testing workflow)

**Phase 3.8 (Comparison)**:
- T078-T082 sequential (comparison testing against original)
- **Prerequisite**: Spec 001 validation must be complete

**Phase 3.9 (Final Validation)**:
- T083-T090 sequential (final validation and reporting)

## Parallel Execution Examples

```bash
# Phase 3.2 - Contract tests (all parallel):
Task: "Contract test GET /health in tests/contract/test_health_contract.py"
Task: "Contract test POST /api/crawl in tests/contract/test_crawl_contract.py"
Task: "Contract test GET /api/collections in tests/contract/test_collections_contract.py"
Task: "Contract test POST /api/query in tests/contract/test_query_contract.py"
Task: "Contract test POST /v1/chat/completions in tests/contract/test_openai_contract.py"

# Phase 3.3 - Configuration modules (all parallel):
Task: "HX Platform configuration in src/config/hx_platform.py"
Task: "Ollama client configuration in src/config/ollama.py"
Task: "Qdrant client configuration in src/config/qdrant.py"
Task: "Redis client configuration in src/config/redis.py"

# Phase 3.3 - Service modules (all parallel):
Task: "Crawl service with Playwright in src/services/crawl_service.py"
Task: "Embedding service with Ollama in src/services/embedding_service.py"
Task: "LLM service with Ollama in src/services/llm_service.py"
Task: "Vector service with Qdrant in src/services/vector_service.py"
Task: "Cache service with Redis in src/services/cache_service.py"
```

## Notes

- **TDD is MANDATORY**: All 21 tests must fail before implementation (T022 gate)
- **Test coverage target**: >80% for production readiness
- **HX Platform dependency**: All HX Platform services must be running (Ollama, Qdrant, Redis)
- **Comparison testing**: Functional parity with original Crawl4AI Agent required
- **Open WebUI integration**: Primary user interface for production use
- **Performance targets**: Must meet spec.md NFRs (crawl <30s, query <5s cached)
- **Circuit breaker required**: Fast-fail pattern for all HX Platform service calls

## Validation Checklist

- [x] All contract tests have corresponding implementation tasks
- [x] All integration tests validate HX Platform services
- [x] Tests come before implementation (TDD workflow)
- [x] Parallel tasks are truly independent (different files)
- [x] Each task specifies exact file path
- [x] No task modifies same file as another [P] task
- [ ] All tasks completed (to be checked during execution)

---

**Total Tasks**: 90
**Estimated Time**: 9-12 days (including testing, deployment, validation)
**Critical Path**: TDD gate (T022), deployment (T067), Open WebUI integration (T072-T077)
**Prerequisites**: Spec 001 complete, HX Platform services operational
