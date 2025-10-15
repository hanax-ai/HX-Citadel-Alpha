# Tasks: Crawl4AI Agent Validation

**Input**: Design documents from `/specs/001-crawl4ai-validation/`
**Prerequisites**: plan.md (complete), research.md (complete)

## Phase 3.1: Setup

- [ ] T001 Verify source code exists at `/home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/`
- [ ] T002 Copy source code to `containers/crawl4ai-agent/src/` preserving directory structure
- [ ] T003 Verify Docker role exists and copy to `ansible/roles/docker/` if needed
- [ ] T004 Create `.env` file from `.env.example` with test OpenAI API key

## Phase 3.2: Pre-Deployment Validation

- [ ] T005 Run Ansible syntax check on `ansible/playbooks/install-docker.yml`
- [ ] T006 Run Ansible syntax check on `ansible/playbooks/deploy-crawl4ai.yml`
- [ ] T007 Verify hx-test-server connectivity: `ansible hx-test-server -i ansible/inventory/test-server.ini -m ping`
- [ ] T008 Check port 11235 availability on hx-test-server

## Phase 3.3: Docker Installation

- [ ] T009 Run `ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/install-docker.yml --check` (dry run)
- [ ] T010 Deploy Docker to hx-test-server: `ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/install-docker.yml`
- [ ] T011 Verify Docker installation: `docker --version` on hx-test-server
- [ ] T012 Verify Docker service running: `systemctl status docker`

## Phase 3.4: Container Deployment

- [ ] T013 Build Crawl4AI Agent container locally for validation: `docker-compose build`
- [ ] T014 Test container health locally before deployment
- [ ] T015 Run `ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-crawl4ai.yml --check` (dry run)
- [ ] T016 Deploy Crawl4AI Agent to hx-test-server: `ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-crawl4ai.yml`
- [ ] T017 Verify container running: `docker ps | grep crawl4ai-agent`
- [ ] T018 Check container logs for errors: `docker logs crawl4ai-agent`

## Phase 3.5: Health Validation

- [ ] T019 Verify health check endpoint: `curl http://hx-test-server:11235/health` returns 200
- [ ] T020 Verify Streamlit UI accessible: `curl -I http://hx-test-server:11235` returns 200
- [ ] T021 Check ChromaDB initialization in container logs
- [ ] T022 Verify Playwright browser installed: check container logs for browser download

## Phase 3.6: Manual Functional Testing

**CRITICAL: Manual validation required - no automated tests**

- [ ] T023 **Manual Test 1**: Access Streamlit UI at http://hx-test-server:11235 in browser
- [ ] T024 **Manual Test 2**: Submit test URL for crawling (https://example.com)
- [ ] T025 **Manual Test 3**: Verify crawl completes and content displays in UI
- [ ] T026 **Manual Test 4**: Verify ChromaDB stores embeddings (check collection in UI)
- [ ] T027 **Manual Test 5**: Submit natural language query about crawled content
- [ ] T028 **Manual Test 6**: Verify LLM response with source citations appears

## Phase 3.7: Regression Baseline Documentation

- [ ] T029 Document crawl results (URL, content extracted, embedding count) in `specs/001-crawl4ai-validation/baseline-results.md`
- [ ] T030 Document query results (question, response, citations) for regression comparison
- [ ] T031 Take screenshots of Streamlit UI for visual regression reference
- [ ] T032 Record performance metrics (crawl time, query time) for baseline

## Phase 3.8: Validation Report

- [ ] T033 Create validation report in `specs/001-crawl4ai-validation/validation-report.md` with:
  - Deployment success/failure
  - Health check results
  - Manual test results (all 6 scenarios)
  - Performance metrics
  - Issues encountered and resolutions
- [ ] T034 Mark spec.md acceptance criteria as passed/failed
- [ ] T035 Document any deviations from expected behavior

## Dependencies

- **T001-T004** can run in parallel (setup tasks, different operations)
- **T005-T008** depend on T001-T004 completion (need Ansible files and source)
- **T009-T012** sequential (Docker installation validation)
- **T013-T018** sequential (container build and deployment)
- **T019-T022** sequential (health validation after deployment)
- **T023-T028** sequential (manual tests, each builds on previous)
- **T029-T032** can run in parallel after T023-T028 (documentation tasks)
- **T033-T035** depend on all previous tasks (final validation report)

## Parallel Execution Example

```bash
# Phase 3.1 - All can run in parallel:
# T001: ls /home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/
# T002: cp -r /home/agent0/.../crawl4AI-agent-v2/* containers/crawl4ai-agent/src/
# T003: Check and copy Docker role
# T004: cp containers/crawl4ai-agent/.env.example .env && nano .env

# Phase 3.7 - Documentation tasks in parallel:
# T029: Write baseline-results.md
# T030: Write query results
# T031: Save screenshots
# T032: Record performance data
```

## Notes

- **No automated tests** - This is a validation baseline using manual testing
- **OpenAI API key required** - Ensure valid key in .env before deployment
- **Manual testing is CRITICAL** - Document results thoroughly for regression comparison
- **Screenshots recommended** - Visual baseline for comparing Citadel Alpha UI later
- **Idempotency**: Ansible playbooks must be safe to re-run (use `--check` first)

## Validation Checklist

- [x] All tasks specify exact commands or file paths
- [x] Manual test scenarios documented clearly
- [x] Dependencies prevent parallel execution of dependent tasks
- [x] Baseline documentation tasks included for regression testing
- [x] Health checks validate deployment success
- [ ] All tasks completed (to be checked during execution)

---

**Total Tasks**: 35
**Estimated Time**: 4-6 hours (including manual testing and documentation)
**Blocking Dependencies**: Docker must be installed before container deployment
