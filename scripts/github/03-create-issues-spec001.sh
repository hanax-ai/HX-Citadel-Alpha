#!/bin/bash
# Create GitHub issues for Spec 001: Crawl4AI Agent Validation (35 tasks)

set -e

REPO="hanax-ai/HX-Citadel-Alpha"
MILESTONE="Spec 001: Crawl4AI Agent Validation"

echo "Creating issues for Spec 001 in $REPO..."

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
}

# Phase 3.1: Setup
create_issue "T001: Verify source code exists" \
"Verify source code exists at \`/home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/\`

**Spec**: 001-crawl4ai-validation
**Phase**: 3.1 Setup
**Command**:
\`\`\`bash
ls -la /home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/
\`\`\`

**Acceptance Criteria**:
- [ ] Directory exists and is readable
- [ ] Contains expected files (streamlit_app.py, requirements.txt, etc.)" \
"spec:001,phase:setup,type:task,priority:high"

create_issue "T002: Copy source code to container directory" \
"Copy source code to \`containers/crawl4ai-agent/src/\` preserving directory structure

**Spec**: 001-crawl4ai-validation
**Phase**: 3.1 Setup
**Command**:
\`\`\`bash
cp -r /home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/* containers/crawl4ai-agent/src/
\`\`\`

**Acceptance Criteria**:
- [ ] All source files copied successfully
- [ ] Directory structure preserved
- [ ] No files overwritten in error" \
"spec:001,phase:setup,type:task,priority:high"

create_issue "T003: Verify and copy Docker role" \
"Verify Docker role exists and copy to \`ansible/roles/docker/\` if needed

**Spec**: 001-crawl4ai-validation
**Phase**: 3.1 Setup
**Command**:
\`\`\`bash
ssh agent0@192.168.10.13 'ls -la /home/agent0/hx-citadel-ansible/roles/docker'
# If exists, copy to local repo
scp -r agent0@192.168.10.13:/home/agent0/hx-citadel-ansible/roles/docker ansible/roles/
\`\`\`

**Acceptance Criteria**:
- [ ] Docker role found on test server or locally
- [ ] Role copied to \`ansible/roles/docker/\`
- [ ] Role structure intact" \
"spec:001,phase:setup,type:task,priority:medium"

create_issue "T004: Create .env file with OpenAI API key" \
"Create \`.env\` file from \`.env.example\` with test OpenAI API key

**Spec**: 001-crawl4ai-validation
**Phase**: 3.1 Setup
**Command**:
\`\`\`bash
cd containers/crawl4ai-agent
cp .env.example .env
# Edit .env with valid OpenAI API key
nano .env
\`\`\`

**Acceptance Criteria**:
- [ ] .env file created
- [ ] OPENAI_API_KEY set with valid key
- [ ] MODEL_CHOICE configured (default: gpt-4-turbo)
- [ ] .env file gitignored (verify)" \
"spec:001,phase:setup,type:task,priority:critical"

# Phase 3.2: Pre-Deployment Validation
create_issue "T005: Ansible syntax check - install-docker.yml" \
"Run Ansible syntax check on \`ansible/playbooks/install-docker.yml\`

**Spec**: 001-crawl4ai-validation
**Phase**: 3.2 Pre-Deployment Validation
**Command**:
\`\`\`bash
ansible-playbook --syntax-check ansible/playbooks/install-docker.yml
\`\`\`

**Acceptance Criteria**:
- [ ] Syntax check passes with no errors
- [ ] FQCN compliance verified" \
"spec:001,phase:validation,type:task,priority:high"

create_issue "T006: Ansible syntax check - deploy-crawl4ai.yml" \
"Run Ansible syntax check on \`ansible/playbooks/deploy-crawl4ai.yml\`

**Spec**: 001-crawl4ai-validation
**Phase**: 3.2 Pre-Deployment Validation
**Command**:
\`\`\`bash
ansible-playbook --syntax-check ansible/playbooks/deploy-crawl4ai.yml
\`\`\`

**Acceptance Criteria**:
- [ ] Syntax check passes with no errors
- [ ] FQCN compliance verified" \
"spec:001,phase:validation,type:task,priority:high"

create_issue "T007: Verify hx-test-server connectivity" \
"Verify hx-test-server connectivity via Ansible ping

**Spec**: 001-crawl4ai-validation
**Phase**: 3.2 Pre-Deployment Validation
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m ping
\`\`\`

**Acceptance Criteria**:
- [ ] Ping succeeds (pong response)
- [ ] SSH connectivity confirmed" \
"spec:001,phase:validation,type:task,priority:critical"

create_issue "T008: Check port 11235 availability" \
"Check port 11235 availability on hx-test-server

**Spec**: 001-crawl4ai-validation
**Phase**: 3.2 Pre-Deployment Validation
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'ss -tlnp | grep 11235'
\`\`\`

**Expected**: No output (port not in use)

**Acceptance Criteria**:
- [ ] Port 11235 is available (not in use)
- [ ] If in use, document conflict and resolve" \
"spec:001,phase:validation,type:task,priority:high"

# Phase 3.3: Docker Installation
create_issue "T009: Docker installation dry run" \
"Run Ansible playbook dry run for Docker installation

**Spec**: 001-crawl4ai-validation
**Phase**: 3.3 Docker Installation
**Command**:
\`\`\`bash
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/install-docker.yml --check
\`\`\`

**Acceptance Criteria**:
- [ ] Dry run completes without errors
- [ ] Shows planned changes (if Docker not installed)" \
"spec:001,phase:deployment,type:task,priority:high"

create_issue "T010: Deploy Docker to hx-test-server" \
"Deploy Docker to hx-test-server using Ansible

**Spec**: 001-crawl4ai-validation
**Phase**: 3.3 Docker Installation
**Command**:
\`\`\`bash
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/install-docker.yml
\`\`\`

**Acceptance Criteria**:
- [ ] Playbook completes successfully
- [ ] Docker installed on hx-test-server
- [ ] No errors in playbook execution" \
"spec:001,phase:deployment,type:deployment,priority:critical"

create_issue "T011: Verify Docker installation" \
"Verify Docker installation on hx-test-server

**Spec**: 001-crawl4ai-validation
**Phase**: 3.3 Docker Installation
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker --version'
\`\`\`

**Acceptance Criteria**:
- [ ] Docker version returned successfully
- [ ] Docker 20.10+ or later installed" \
"spec:001,phase:validation,type:task,priority:high"

create_issue "T012: Verify Docker service running" \
"Verify Docker service is running on hx-test-server

**Spec**: 001-crawl4ai-validation
**Phase**: 3.3 Docker Installation
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'systemctl status docker'
\`\`\`

**Acceptance Criteria**:
- [ ] Docker service is active (running)
- [ ] Docker service enabled on boot" \
"spec:001,phase:validation,type:task,priority:high"

# Phase 3.4: Container Deployment
create_issue "T013: Build Crawl4AI Agent container locally" \
"Build Crawl4AI Agent container locally for validation

**Spec**: 001-crawl4ai-validation
**Phase**: 3.4 Container Deployment
**Command**:
\`\`\`bash
cd containers/crawl4ai-agent
docker-compose build
\`\`\`

**Acceptance Criteria**:
- [ ] Container builds successfully
- [ ] No build errors
- [ ] Playwright browsers installed in image" \
"spec:001,phase:deployment,type:task,priority:high"

create_issue "T014: Test container health locally" \
"Test container health locally before deployment

**Spec**: 001-crawl4ai-validation
**Phase**: 3.4 Container Deployment
**Command**:
\`\`\`bash
cd containers/crawl4ai-agent
docker-compose up -d
sleep 40
curl http://localhost:11235
docker-compose down
\`\`\`

**Acceptance Criteria**:
- [ ] Container starts successfully
- [ ] Health check passes within 40s
- [ ] Port 11235 responds" \
"spec:001,phase:validation,type:task,priority:high"

create_issue "T015: Deploy Crawl4AI Agent dry run" \
"Run Ansible playbook dry run for Crawl4AI deployment

**Spec**: 001-crawl4ai-validation
**Phase**: 3.4 Container Deployment
**Command**:
\`\`\`bash
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-crawl4ai.yml --check
\`\`\`

**Acceptance Criteria**:
- [ ] Dry run completes without errors
- [ ] Shows planned deployment changes" \
"spec:001,phase:deployment,type:task,priority:high"

create_issue "T016: Deploy Crawl4AI Agent to hx-test-server" \
"Deploy Crawl4AI Agent to hx-test-server using Ansible

**Spec**: 001-crawl4ai-validation
**Phase**: 3.4 Container Deployment
**Command**:
\`\`\`bash
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-crawl4ai.yml
\`\`\`

**Acceptance Criteria**:
- [ ] Playbook completes successfully
- [ ] Container deployed to hx-test-server
- [ ] No errors in deployment" \
"spec:001,phase:deployment,type:deployment,priority:critical"

create_issue "T017: Verify container running" \
"Verify Crawl4AI Agent container is running on hx-test-server

**Spec**: 001-crawl4ai-validation
**Phase**: 3.4 Container Deployment
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker ps | grep crawl4ai-agent'
\`\`\`

**Acceptance Criteria**:
- [ ] Container is running
- [ ] Status shows 'Up' not 'Restarting'" \
"spec:001,phase:validation,type:task,priority:critical"

create_issue "T018: Check container logs for errors" \
"Check container logs for errors after deployment

**Spec**: 001-crawl4ai-validation
**Phase**: 3.4 Container Deployment
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker logs crawl4ai-agent'
\`\`\`

**Acceptance Criteria**:
- [ ] No critical errors in logs
- [ ] Streamlit app started successfully
- [ ] ChromaDB initialized" \
"spec:001,phase:validation,type:task,priority:high"

# Phase 3.5: Health Validation
create_issue "T019: Verify health check endpoint" \
"Verify health check endpoint returns 200

**Spec**: 001-crawl4ai-validation
**Phase**: 3.5 Health Validation
**Command**:
\`\`\`bash
curl http://hx-test-server:11235/health
\`\`\`

**Acceptance Criteria**:
- [ ] Returns HTTP 200 status
- [ ] Response indicates healthy status" \
"spec:001,phase:validation,type:task,priority:critical"

create_issue "T020: Verify Streamlit UI accessible" \
"Verify Streamlit UI is accessible

**Spec**: 001-crawl4ai-validation
**Phase**: 3.5 Health Validation
**Command**:
\`\`\`bash
curl -I http://hx-test-server:11235
\`\`\`

**Acceptance Criteria**:
- [ ] Returns HTTP 200 status
- [ ] Headers indicate Streamlit response" \
"spec:001,phase:validation,type:task,priority:critical"

create_issue "T021: Check ChromaDB initialization" \
"Check ChromaDB initialization in container logs

**Spec**: 001-crawl4ai-validation
**Phase**: 3.5 Health Validation
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker logs crawl4ai-agent | grep -i chroma'
\`\`\`

**Acceptance Criteria**:
- [ ] ChromaDB initialized successfully
- [ ] No database errors in logs" \
"spec:001,phase:validation,type:task,priority:medium"

create_issue "T022: Verify Playwright browser installed" \
"Verify Playwright browser installed in container

**Spec**: 001-crawl4ai-validation
**Phase**: 3.5 Health Validation
**Command**:
\`\`\`bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a 'docker logs crawl4ai-agent | grep -i playwright'
\`\`\`

**Acceptance Criteria**:
- [ ] Playwright browsers downloaded/installed
- [ ] No browser installation errors" \
"spec:001,phase:validation,type:task,priority:medium"

# Phase 3.6: Manual Functional Testing
create_issue "T023: Manual Test 1 - Access Streamlit UI" \
"**MANUAL TEST**: Access Streamlit UI at http://hx-test-server:11235 in browser

**Spec**: 001-crawl4ai-validation
**Phase**: 3.6 Manual Functional Testing

**Steps**:
1. Open browser
2. Navigate to http://hx-test-server:11235
3. Verify Streamlit UI loads
4. Take screenshot for documentation

**Acceptance Criteria**:
- [ ] UI loads without errors
- [ ] Streamlit interface displays correctly
- [ ] Input fields visible
- [ ] Screenshot saved to \`specs/001-crawl4ai-validation/screenshots/\`" \
"spec:001,phase:validation,type:test,manual-test,priority:critical"

create_issue "T024: Manual Test 2 - Submit test URL for crawling" \
"**MANUAL TEST**: Submit test URL for crawling (https://example.com)

**Spec**: 001-crawl4ai-validation
**Phase**: 3.6 Manual Functional Testing

**Steps**:
1. Access UI at http://hx-test-server:11235
2. Enter URL: https://example.com
3. Click 'Crawl' button
4. Observe crawling process

**Acceptance Criteria**:
- [ ] Crawl starts successfully
- [ ] Progress indicator shows activity
- [ ] No errors displayed in UI" \
"spec:001,phase:validation,type:test,manual-test,priority:critical"

create_issue "T025: Manual Test 3 - Verify crawl completion" \
"**MANUAL TEST**: Verify crawl completes and content displays in UI

**Spec**: 001-crawl4ai-validation
**Phase**: 3.6 Manual Functional Testing

**Steps**:
1. Wait for crawl to complete (from T024)
2. Verify content extracted and displayed
3. Check for errors or warnings
4. Document results

**Acceptance Criteria**:
- [ ] Crawl completes within 30s
- [ ] Page content extracted and visible
- [ ] No errors in UI
- [ ] Results documented in validation report" \
"spec:001,phase:validation,type:test,manual-test,priority:critical"

create_issue "T026: Manual Test 4 - Verify ChromaDB embeddings stored" \
"**MANUAL TEST**: Verify ChromaDB stores embeddings

**Spec**: 001-crawl4ai-validation
**Phase**: 3.6 Manual Functional Testing

**Steps**:
1. After crawl completion (T025)
2. Check UI for embedding count/collection info
3. Verify embeddings stored successfully

**Acceptance Criteria**:
- [ ] Embeddings generated from crawled content
- [ ] ChromaDB collection created
- [ ] Embedding count > 0" \
"spec:001,phase:validation,type:test,manual-test,priority:high"

create_issue "T027: Manual Test 5 - Submit natural language query" \
"**MANUAL TEST**: Submit natural language query about crawled content

**Spec**: 001-crawl4ai-validation
**Phase**: 3.6 Manual Functional Testing

**Steps**:
1. In Streamlit UI, submit query: 'What is the main purpose of this website?'
2. Wait for LLM processing
3. Observe response

**Acceptance Criteria**:
- [ ] Query accepted by UI
- [ ] LLM processing initiated
- [ ] OpenAI API called successfully" \
"spec:001,phase:validation,type:test,manual-test,priority:critical"

create_issue "T028: Manual Test 6 - Verify LLM response with citations" \
"**MANUAL TEST**: Verify LLM response with source citations appears

**Spec**: 001-crawl4ai-validation
**Phase**: 3.6 Manual Functional Testing

**Steps**:
1. After query submission (T027)
2. Wait for response
3. Verify response quality and citations
4. Document response

**Acceptance Criteria**:
- [ ] Response generated within 10s
- [ ] Response relevant to query
- [ ] Source citations included
- [ ] Response documented for baseline" \
"spec:001,phase:validation,type:test,manual-test,priority:critical"

# Phase 3.7: Regression Baseline Documentation
create_issue "T029: Document crawl results baseline" \
"Document crawl results (URL, content extracted, embedding count) in baseline-results.md

**Spec**: 001-crawl4ai-validation
**Phase**: 3.7 Regression Baseline Documentation

**File**: \`specs/001-crawl4ai-validation/baseline-results.md\`

**Content to document**:
- URL crawled
- Content extracted (summary)
- Embedding count
- Crawl duration
- Timestamp

**Acceptance Criteria**:
- [ ] baseline-results.md created
- [ ] All crawl data documented
- [ ] File committed to repo" \
"spec:001,phase:validation,type:documentation,parallel,priority:high"

create_issue "T030: Document query results baseline" \
"Document query results (question, response, citations) for regression comparison

**Spec**: 001-crawl4ai-validation
**Phase**: 3.7 Regression Baseline Documentation

**File**: \`specs/001-crawl4ai-validation/baseline-results.md\`

**Content to document**:
- Query submitted
- LLM response
- Citations/sources
- Response time
- Model used

**Acceptance Criteria**:
- [ ] Query results documented
- [ ] Response quality noted
- [ ] File updated and committed" \
"spec:001,phase:validation,type:documentation,parallel,priority:high"

create_issue "T031: Save screenshots for visual regression" \
"Take screenshots of Streamlit UI for visual regression reference

**Spec**: 001-crawl4ai-validation
**Phase**: 3.7 Regression Baseline Documentation

**Screenshots needed**:
- UI home page
- Crawl in progress
- Crawl results display
- Query interface
- Query response

**Location**: \`specs/001-crawl4ai-validation/screenshots/\`

**Acceptance Criteria**:
- [ ] All 5 screenshots captured
- [ ] Screenshots clear and labeled
- [ ] Stored in Git LFS or documented location" \
"spec:001,phase:validation,type:documentation,parallel,priority:medium"

create_issue "T032: Record performance metrics baseline" \
"Record performance metrics (crawl time, query time) for baseline

**Spec**: 001-crawl4ai-validation
**Phase**: 3.7 Regression Baseline Documentation

**Metrics to record**:
- Page crawl time (target: <30s)
- Embedding generation time (target: <5s)
- Query response time (target: <10s)
- Resource usage (memory, CPU)

**File**: \`specs/001-crawl4ai-validation/baseline-results.md\`

**Acceptance Criteria**:
- [ ] All metrics documented
- [ ] Comparison with spec targets
- [ ] Baseline established for Citadel Alpha comparison" \
"spec:001,phase:validation,type:documentation,parallel,priority:high"

# Phase 3.8: Validation Report
create_issue "T033: Create validation report" \
"Create validation report in \`specs/001-crawl4ai-validation/validation-report.md\`

**Spec**: 001-crawl4ai-validation
**Phase**: 3.8 Validation Report

**Report sections**:
- Deployment success/failure
- Health check results
- Manual test results (all 6 scenarios)
- Performance metrics
- Issues encountered and resolutions
- Comparison with spec requirements

**Acceptance Criteria**:
- [ ] Report created with all sections
- [ ] All tests documented
- [ ] Issues and resolutions noted" \
"spec:001,phase:validation,type:documentation,priority:critical"

create_issue "T034: Mark spec.md acceptance criteria" \
"Mark spec.md acceptance criteria as passed/failed

**Spec**: 001-crawl4ai-validation
**Phase**: 3.8 Validation Report

**File**: \`specs/001-crawl4ai-validation/spec.md\`

**Actions**:
- Review all acceptance criteria in spec
- Mark each as passed ✅ or failed ❌
- Document any deviations

**Acceptance Criteria**:
- [ ] All acceptance criteria reviewed
- [ ] Pass/fail status documented
- [ ] File updated and committed" \
"spec:001,phase:validation,type:documentation,priority:high"

create_issue "T035: Document deviations from expected behavior" \
"Document any deviations from expected behavior

**Spec**: 001-crawl4ai-validation
**Phase**: 3.8 Validation Report

**File**: \`specs/001-crawl4ai-validation/validation-report.md\`

**Document**:
- Any unexpected behaviors
- Performance deviations from spec
- Functionality differences
- Recommendations for Citadel Alpha

**Acceptance Criteria**:
- [ ] All deviations documented
- [ ] Root causes analyzed
- [ ] Impact assessment included
- [ ] Report finalized and committed" \
"spec:001,phase:validation,type:documentation,priority:high"

echo ""
echo "✅ Created 35 issues for Spec 001: Crawl4AI Agent Validation"
echo ""
echo "Next step: Run 04-create-issues-spec002.sh"
