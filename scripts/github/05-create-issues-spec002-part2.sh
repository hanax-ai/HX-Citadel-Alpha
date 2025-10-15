#!/bin/bash
# Create GitHub issues for Spec 002: Citadel Alpha (Part 2 - Tasks T050-T090)
# Continuation of 04-create-issues-spec002.sh

set -e

REPO="hanax-ai/HX-Citadel-Alpha"
MILESTONE="Spec 002: Citadel Alpha HX Platform Integration"

echo "Creating remaining issues for Spec 002 in $REPO..."
echo "This will create 41 more issues (T050-T090)..."

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

# Phase 3.5: Polish - Unit Tests
echo "Creating Phase 3.5: Polish - Unit Tests (3 tasks)..."

create_issue "T050: Unit tests for configuration loading" \
"Unit tests for configuration loading in tests/unit/test_config.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish
**File**: \`containers/citadel-alpha/tests/unit/test_config.py\`

**Tests to write**:
- [ ] Test HXPlatformConfig loading from env vars
- [ ] Test OllamaConfig validation
- [ ] Test QdrantConfig validation
- [ ] Test RedisConfig validation
- [ ] Test invalid configurations raise errors

**Acceptance Criteria**:
- [ ] All config modules tested
- [ ] Edge cases covered
- [ ] Tests passing" \
"spec:002,phase:polish,type:test,priority:medium,parallel"

create_issue "T051: Unit tests for crawl service" \
"Unit tests for crawl service in tests/unit/test_crawl_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish
**File**: \`containers/citadel-alpha/tests/unit/test_crawl_service.py\`

**Tests to write**:
- [ ] Test content extraction
- [ ] Test chunking logic
- [ ] Test metadata extraction
- [ ] Test error handling
- [ ] Test timeout scenarios

**Acceptance Criteria**:
- [ ] Core logic tested
- [ ] Mocking external dependencies
- [ ] Tests passing" \
"spec:002,phase:polish,type:test,priority:medium,parallel"

create_issue "T052: Unit tests for cache service" \
"Unit tests for cache service in tests/unit/test_cache_service.py

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish
**File**: \`containers/citadel-alpha/tests/unit/test_cache_service.py\`

**Tests to write**:
- [ ] Test cache key generation
- [ ] Test TTL expiration
- [ ] Test cache hit/miss logic
- [ ] Test invalidation
- [ ] Test serialization/deserialization

**Acceptance Criteria**:
- [ ] Cache logic thoroughly tested
- [ ] Mock Redis client
- [ ] Tests passing" \
"spec:002,phase:polish,type:test,priority:medium,parallel"

# Phase 3.5: Polish - Performance Tests
echo "Creating Phase 3.5: Performance Tests (4 tasks)..."

create_issue "T053: Performance test - Concurrent crawls" \
"Performance test: 5 concurrent crawls meet <30s target

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Test Requirements**:
- [ ] Submit 5 concurrent crawl requests
- [ ] Measure completion time for each
- [ ] Verify all complete within 30s
- [ ] Document resource usage

**Acceptance Criteria**:
- [ ] All crawls complete successfully
- [ ] Performance target met (<30s each)
- [ ] Results documented" \
"spec:002,phase:polish,type:test,priority:high"

create_issue "T054: Performance test - Embedding generation" \
"Performance test: Embedding generation <10s per page

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Test Requirements**:
- [ ] Crawl typical web page
- [ ] Measure embedding generation time
- [ ] Verify <10s target met
- [ ] Test with different page sizes

**Acceptance Criteria**:
- [ ] Performance target met
- [ ] Batch processing optimized
- [ ] Results documented" \
"spec:002,phase:polish,type:test,priority:high,hx-platform"

create_issue "T055: Performance test - Cached query response" \
"Performance test: Cached query response <5s

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Test Requirements**:
- [ ] Submit query for cached content
- [ ] Measure response time
- [ ] Verify <5s target met
- [ ] Validate cache hit

**Acceptance Criteria**:
- [ ] Cache hit confirmed
- [ ] Performance target met (<5s)
- [ ] Results documented" \
"spec:002,phase:polish,type:test,priority:high,hx-platform"

create_issue "T056: Performance test - Uncached query response" \
"Performance test: Uncached query response <15s

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Test Requirements**:
- [ ] Submit query for uncached content
- [ ] Measure full RAG pipeline time
- [ ] Verify <15s target met
- [ ] Document pipeline breakdown

**Acceptance Criteria**:
- [ ] Full RAG workflow tested
- [ ] Performance target met (<15s)
- [ ] Bottlenecks identified if any" \
"spec:002,phase:polish,type:test,priority:high,hx-platform"

# Phase 3.5: Polish - Documentation
echo "Creating Phase 3.5: Documentation (3 tasks)..."

create_issue "T057: Update README.md with API usage examples" \
"Update README.md with API usage examples

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish
**File**: \`containers/citadel-alpha/README.md\`

**Content to add**:
- [ ] API endpoint examples with curl
- [ ] Python client example code
- [ ] Open WebUI integration guide
- [ ] Troubleshooting section

**Acceptance Criteria**:
- [ ] README comprehensive and clear
- [ ] Examples tested and working
- [ ] File updated and committed" \
"spec:002,phase:polish,type:documentation,priority:medium,parallel"

create_issue "T058: Update CLAUDE.md with HX Platform patterns" \
"Update CLAUDE.md with HX Platform integration patterns

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish
**File**: \`CLAUDE.md\`

**Content to add**:
- [ ] HX Platform service endpoints
- [ ] Common commands for testing integration
- [ ] Troubleshooting guide for connectivity
- [ ] Circuit breaker patterns

**Acceptance Criteria**:
- [ ] CLAUDE.md updated
- [ ] Patterns documented clearly
- [ ] File committed" \
"spec:002,phase:polish,type:documentation,priority:medium,parallel"

create_issue "T059: Generate API documentation from OpenAPI" \
"Generate API documentation using FastAPI OpenAPI autogeneration

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Requirements**:
- [ ] Verify /docs endpoint working
- [ ] Export OpenAPI spec to docs/api/openapi.yaml
- [ ] Generate markdown from OpenAPI (optional)
- [ ] Test all endpoints in Swagger UI

**Acceptance Criteria**:
- [ ] API docs accessible at /docs
- [ ] OpenAPI spec exported
- [ ] All endpoints documented" \
"spec:002,phase:polish,type:documentation,priority:medium,parallel"

# Phase 3.5: Polish - Cleanup
echo "Creating Phase 3.5: Cleanup (3 tasks)..."

create_issue "T060: Remove code duplication (DRY refactoring)" \
"Remove code duplication (DRY refactoring)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Areas to review**:
- [ ] Service layer repeated patterns
- [ ] Error handling duplication
- [ ] Configuration loading logic
- [ ] Logging setup

**Acceptance Criteria**:
- [ ] Code duplication reduced
- [ ] Common utilities extracted
- [ ] Tests still passing" \
"spec:002,phase:polish,type:task,priority:low"

create_issue "T061: Run linting tools and fix all issues" \
"Run linting tools (ruff, mypy, black) and fix all issues

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Commands**:
\`\`\`bash
ruff check src/ tests/ --fix
mypy src/
black src/ tests/
\`\`\`

**Acceptance Criteria**:
- [ ] Ruff: No linting errors
- [ ] Mypy: Type checking passes
- [ ] Black: Code formatted
- [ ] All tools pass clean" \
"spec:002,phase:polish,type:task,priority:medium"

create_issue "T062: Verify test coverage >80%" \
"Verify test coverage >80% using pytest-cov

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.5 Polish

**Command**:
\`\`\`bash
pytest --cov=src --cov-report=html --cov-report=term
\`\`\`

**Acceptance Criteria**:
- [ ] Overall coverage >80%
- [ ] Critical modules >90% (services, API routes)
- [ ] Coverage report generated
- [ ] Gaps documented" \
"spec:002,phase:polish,type:test,priority:high"

# Phase 3.6: Deployment & Validation
echo "Creating Phase 3.6: Deployment (9 tasks)..."

create_issue "T063: Build Citadel Alpha container locally" \
"Build Citadel Alpha container locally for validation

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
cd containers/citadel-alpha
docker-compose build
\`\`\`

**Acceptance Criteria**:
- [ ] Container builds successfully
- [ ] No build errors
- [ ] All dependencies installed" \
"spec:002,phase:deployment,type:task,priority:critical"

create_issue "T064: Test container health locally" \
"Test container health locally before deployment

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
cd containers/citadel-alpha
docker-compose up -d
sleep 40
curl http://localhost:11236/health
curl http://localhost:11236/health/integrations
docker-compose down
\`\`\`

**Acceptance Criteria**:
- [ ] Container starts successfully
- [ ] Health checks pass
- [ ] Port 11236 responds" \
"spec:002,phase:deployment,type:task,priority:critical,hx-platform"

create_issue "T065: Verify HX Platform services reachable from container" \
"Verify HX Platform services reachable from container

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Services to test**:
- [ ] Ollama embeddings (hx-orchestrator-server:11434)
- [ ] Ollama LLM (hx-ollama1:11434)
- [ ] Qdrant (hx-vectordb-server:6333)
- [ ] Redis (hx-sqldb-server:6379)

**Acceptance Criteria**:
- [ ] All services reachable
- [ ] Network configuration correct
- [ ] No connectivity issues" \
"spec:002,phase:deployment,type:task,priority:critical,hx-platform"

create_issue "T066: Ansible pre-flight checks (dry run)" \
"Run Ansible pre-flight checks with --check flag

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-citadel-alpha.yml --check
\`\`\`

**Acceptance Criteria**:
- [ ] Dry run completes without errors
- [ ] Shows planned deployment changes
- [ ] Ready for actual deployment" \
"spec:002,phase:deployment,type:task,priority:high"

create_issue "T067: Deploy Citadel Alpha to hx-test-server" \
"Deploy Citadel Alpha to hx-test-server using Ansible

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-citadel-alpha.yml
\`\`\`

**Acceptance Criteria**:
- [ ] Playbook completes successfully
- [ ] Container deployed to hx-test-server
- [ ] No deployment errors" \
"spec:002,phase:deployment,type:deployment,priority:critical"

create_issue "T068: Verify container running on hx-test-server" \
"Verify Citadel Alpha container is running

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker ps | grep citadel-alpha'
\`\`\`

**Acceptance Criteria**:
- [ ] Container running
- [ ] Status shows 'Up' not 'Restarting'
- [ ] Port 11236 mapped" \
"spec:002,phase:deployment,type:task,priority:critical"

create_issue "T069: Check container logs for errors" \
"Check container logs for errors after deployment

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker logs citadel-alpha'
\`\`\`

**Acceptance Criteria**:
- [ ] No critical errors in logs
- [ ] FastAPI app started
- [ ] HX Platform services connected" \
"spec:002,phase:deployment,type:task,priority:high"

create_issue "T070: Verify health endpoint responds" \
"Verify health endpoint returns 200

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
curl http://hx-test-server:11236/health
\`\`\`

**Acceptance Criteria**:
- [ ] Returns HTTP 200
- [ ] Response indicates healthy status" \
"spec:002,phase:deployment,type:task,priority:critical"

create_issue "T071: Verify integration status endpoint" \
"Verify integration status endpoint shows all services healthy

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.6 Deployment & Validation

**Command**:
\`\`\`bash
curl http://hx-test-server:11236/health/integrations | jq
\`\`\`

**Acceptance Criteria**:
- [ ] All HX Platform services show 'healthy'
- [ ] Latency metrics present
- [ ] Circuit breaker states shown" \
"spec:002,phase:deployment,type:task,priority:critical,hx-platform"

# Phase 3.7: Open WebUI Integration
echo "Creating Phase 3.7: Open WebUI Integration (6 tasks)..."

create_issue "T072: Configure Open WebUI connection" \
"Configure Open WebUI connection to Citadel Alpha API

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.7 Open WebUI Integration

**Configuration**:
- Base URL: http://hx-test-server:11236/v1
- API Key: (from HX_API_KEY env var)

**Steps**:
1. Access Open WebUI at hx-webui-server:8080
2. Settings → Connections → OpenAI API
3. Add new connection with base URL
4. Test connection

**Acceptance Criteria**:
- [ ] Connection configured
- [ ] Connection test passes
- [ ] Model 'citadel-alpha' appears" \
"spec:002,phase:validation,type:task,priority:critical,hx-platform"

create_issue "T073: Test chat message with crawl command" \
"Test chat message: 'Crawl https://example.com and summarize'

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.7 Open WebUI Integration

**Steps**:
1. In Open WebUI chat
2. Send message: 'Crawl https://example.com and summarize'
3. Wait for response

**Acceptance Criteria**:
- [ ] Message sent successfully
- [ ] Crawl initiated
- [ ] Response received" \
"spec:002,phase:validation,type:test,manual-test,priority:critical,hx-platform"

create_issue "T074: Verify crawl execution and LLM response" \
"Verify crawl executes and LLM response includes summary

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.7 Open WebUI Integration

**Validation**:
- [ ] Crawl completed successfully
- [ ] LLM summary generated
- [ ] Summary relevant to page content
- [ ] Sources/citations included

**Acceptance Criteria**:
- [ ] Full workflow working
- [ ] Response quality acceptable
- [ ] Timing within targets" \
"spec:002,phase:validation,type:test,manual-test,priority:critical,hx-platform"

create_issue "T075: Verify Qdrant stores embeddings" \
"Verify Qdrant stores embeddings from Open WebUI crawl

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.7 Open WebUI Integration

**Check**:
\`\`\`bash
curl http://hx-test-server:11236/api/collections
\`\`\`

**Acceptance Criteria**:
- [ ] Collection 'citadel_alpha_crawls' exists
- [ ] Points count > 0 (embeddings stored)
- [ ] Vectors count matches chunks" \
"spec:002,phase:validation,type:test,priority:high,hx-platform"

create_issue "T076: Test follow-up query" \
"Test follow-up query: 'What was the main topic?'

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.7 Open WebUI Integration

**Steps**:
1. After T074 crawl completes
2. Send follow-up: 'What was the main topic?'
3. Verify response uses cached/stored data

**Acceptance Criteria**:
- [ ] Query processed successfully
- [ ] Response relevant to original page
- [ ] Response time <5s (cache hit)" \
"spec:002,phase:validation,type:test,manual-test,priority:high,hx-platform"

create_issue "T077: Verify RAG retrieval uses stored data" \
"Verify RAG retrieval uses cached/stored data

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.7 Open WebUI Integration

**Validation**:
- [ ] Check Redis cache hit (if available)
- [ ] Check Qdrant vector search executed
- [ ] Verify response uses stored embeddings

**Acceptance Criteria**:
- [ ] RAG workflow confirmed
- [ ] No redundant crawl
- [ ] Performance target met" \
"spec:002,phase:validation,type:test,priority:medium,hx-platform"

# Phase 3.8: Comparison Testing
echo "Creating Phase 3.8: Comparison Testing (5 tasks)..."

create_issue "T078: Run same URL crawl in both containers" \
"Run same URL crawl in both containers (original vs Citadel Alpha)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.8 Comparison Testing

**Crawl**:
- URL: https://example.com
- Original: http://hx-test-server:11235 (Streamlit)
- Citadel: http://hx-test-server:11236/api/crawl (FastAPI)

**Acceptance Criteria**:
- [ ] Both crawls completed successfully
- [ ] Timing data recorded
- [ ] Results ready for comparison" \
"spec:002,phase:validation,type:test,priority:high"

create_issue "T079: Compare content extraction" \
"Compare content extraction between original and Citadel Alpha

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.8 Comparison Testing

**Comparison**:
- [ ] Same text extracted from page?
- [ ] Similar chunk sizes?
- [ ] Metadata completeness
- [ ] Edge cases handled

**Acceptance Criteria**:
- [ ] Functional parity confirmed
- [ ] Differences documented if any
- [ ] Quality acceptable" \
"spec:002,phase:validation,type:test,priority:high"

create_issue "T080: Compare embedding quality" \
"Compare embedding quality (vector distributions)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.8 Comparison Testing

**Comparison**:
- Original: OpenAI embeddings
- Citadel: Ollama mxbai-embed-large
- Dimensions: OpenAI (1536?) vs Ollama (1024)

**Analysis**:
- [ ] Vector similarity between same content
- [ ] Cluster quality
- [ ] Search relevance

**Acceptance Criteria**:
- [ ] Embedding quality comparable
- [ ] Differences documented
- [ ] Citadel embeddings acceptable for production" \
"spec:002,phase:validation,type:test,priority:medium,hx-platform"

create_issue "T081: Compare query relevance" \
"Compare query relevance (same chunks retrieved?)

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.8 Comparison Testing

**Test Query**: 'What is the purpose of this website?'

**Comparison**:
- [ ] Similar chunks retrieved?
- [ ] Relevance scores comparable?
- [ ] LLM responses similar quality?

**Acceptance Criteria**:
- [ ] Query results comparable
- [ ] Citadel retrieval quality acceptable
- [ ] Differences explained" \
"spec:002,phase:validation,type:test,priority:high,hx-platform"

create_issue "T082: Document functional parity assessment" \
"Document functional parity in comparison-report.md

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.8 Comparison Testing
**File**: \`specs/002-citadel-alpha-integration/comparison-report.md\`

**Report sections**:
- Content extraction comparison
- Embedding quality comparison
- Query relevance comparison
- Performance comparison
- Feature parity assessment
- Production readiness recommendation

**Acceptance Criteria**:
- [ ] Report completed
- [ ] All comparisons documented
- [ ] Recommendation clear" \
"spec:002,phase:validation,type:documentation,priority:high"

# Phase 3.9: Final Validation
echo "Creating Phase 3.9: Final Validation (8 tasks)..."

create_issue "T083: Run full test suite with coverage" \
"Run full test suite with coverage report

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation

**Command**:
\`\`\`bash
pytest tests/ -v --cov=src --cov-report=html --cov-report=term
\`\`\`

**Acceptance Criteria**:
- [ ] All tests passing
- [ ] Coverage >80%
- [ ] Coverage report generated" \
"spec:002,phase:validation,type:test,priority:critical"

create_issue "T084: Verify contract tests passing (21/21)" \
"Verify all 21 contract tests passing

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation

**Command**:
\`\`\`bash
pytest tests/contract/ -v
\`\`\`

**Expected**: 21/21 passing (10 contract + integration tests)

**Acceptance Criteria**:
- [ ] All contract tests pass
- [ ] OpenAPI compliance verified" \
"spec:002,phase:validation,type:test,priority:critical"

create_issue "T085: Verify integration tests passing" \
"Verify all integration tests passing

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation

**Command**:
\`\`\`bash
pytest tests/integration/ -v
\`\`\`

**Acceptance Criteria**:
- [ ] All integration tests pass
- [ ] HX Platform connectivity confirmed" \
"spec:002,phase:validation,type:test,priority:critical,hx-platform"

create_issue "T086: Verify unit tests passing" \
"Verify all unit tests passing

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation

**Command**:
\`\`\`bash
pytest tests/unit/ -v
\`\`\`

**Acceptance Criteria**:
- [ ] All unit tests pass
- [ ] Code logic validated" \
"spec:002,phase:validation,type:test,priority:high"

create_issue "T087: Verify test coverage >80%" \
"Final verification: test coverage >80%

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation

**Check**:
- [ ] Overall coverage >80%
- [ ] Service layer >85%
- [ ] API routes >90%
- [ ] Config >80%

**Acceptance Criteria**:
- [ ] Coverage targets met
- [ ] Production ready" \
"spec:002,phase:validation,type:test,priority:critical"

create_issue "T088: Create final validation report" \
"Create validation report in validation-report.md

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation
**File**: \`specs/002-citadel-alpha-integration/validation-report.md\`

**Report sections**:
- Deployment status
- Test results summary (contract, integration, unit)
- Performance benchmarks
- HX Platform integration status
- Open WebUI integration status
- Comparison with original Crawl4AI
- Issues and resolutions
- Production readiness assessment

**Acceptance Criteria**:
- [ ] Report comprehensive
- [ ] All validations documented
- [ ] Recommendation provided" \
"spec:002,phase:validation,type:documentation,priority:critical"

create_issue "T089: Mark spec.md acceptance criteria" \
"Mark spec.md acceptance criteria as passed/failed

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation
**File**: \`specs/002-citadel-alpha-integration/spec.md\`

**Actions**:
- Review all acceptance criteria in spec
- Mark each as passed ✅ or failed ❌
- Document any deviations

**Acceptance Criteria**:
- [ ] All criteria reviewed
- [ ] Status documented
- [ ] File committed" \
"spec:002,phase:validation,type:documentation,priority:high"

create_issue "T090: Document production readiness assessment" \
"Document production readiness assessment

**Spec**: 002-citadel-alpha-integration
**Phase**: 3.9 Final Validation
**File**: \`specs/002-citadel-alpha-integration/validation-report.md\`

**Assessment criteria**:
- [ ] All tests passing (>80% coverage)
- [ ] HX Platform integration working
- [ ] Open WebUI integration working
- [ ] Performance targets met
- [ ] Functional parity with original
- [ ] Security review (basic)
- [ ] Documentation complete

**Recommendation**: GO/NO-GO for production

**Acceptance Criteria**:
- [ ] Assessment complete
- [ ] Recommendation clear
- [ ] Report finalized and committed" \
"spec:002,phase:validation,type:documentation,priority:critical"

echo ""
echo "✅ Created 41 issues (T050-T090) for Spec 002: Citadel Alpha HX Platform Integration"
echo ""
echo "Total issues created: 90 for Spec 002 + 35 for Spec 001 = 125 issues"
echo ""
echo "Next step: Run 06-add-issues-to-project.sh to add all issues to project board"
