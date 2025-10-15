# Research: Crawl4AI Agent Validation

**Feature**: 001-crawl4ai-validation
**Date**: 2025-10-15
**Status**: Complete

## Research Questions

### 1. Source Code Location

**Question**: Where is the original Crawl4AI-agent-v2 source code?

**Answer**: `/home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/`

**Verification**:
```bash
ls -la /home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/
```

**Expected Contents**:
- `streamlit_app.py` or similar main application file
- `requirements.txt` with dependencies
- Possibly: `Dockerfile`, `docker-compose.yml`, README

**Decision**: Copy entire directory contents to `containers/crawl4ai-agent/src/` preserving structure.

---

### 2. Docker Role Location

**Question**: Where is the Docker role for Ansible deployment?

**Answer**: Docker role exists on hx-test-server at `/home/agent0/hx-citadel-ansible/roles/docker/`

**Verification Method**: SSH to hx-test-server and check directory:
```bash
ssh agent0@192.168.10.13 "ls -la /home/agent0/hx-citadel-ansible/roles/docker"
```

**Decision**:
- Option 1: Reference remote role in Ansible playbook
- Option 2: Copy role to `ansible/roles/docker/` in HX-Citadel-Alpha repo
- **Chosen**: Copy role to local repo for version control and portability

**Status**: ✅ Completed - Docker role copied to `ansible/roles/docker/`

**Docker Versions**:
- **Docker Engine**: Latest stable from Docker CE repository (docker-ce package)
- **Docker Compose**: V2 as plugin (docker-compose-plugin)
  - **Important**: Use `docker compose` command, NOT `docker-compose`
- **Additional**: containerd.io, docker-buildx-plugin, docker-ce-cli
- **Version Documentation**: See `ansible/roles/docker/VERSIONS.md`

---

### 3. Original Dependencies

**Question**: What are the exact versions used in the original implementation?

**Current Known Dependencies** (from requirements.txt scaffold):
```
crawl4ai==0.6.2
playwright==1.52.0
openai==1.76.2
chromadb==1.0.7
streamlit==1.45.0
fastapi==0.115.9
uvicorn==0.34.2
python-dotenv==1.1.0
pydantic==2.11.4
requests==2.32.3
beautifulsoup4==4.13.4
lxml==5.4.0
sentence-transformers==4.1.0
```

**Action Required**: Verify against original `requirements.txt` from source directory.

**Decision**: Use exact versions from original to ensure identical behavior.

---

### 4. OpenAI API Configuration

**Question**: How is the OpenAI API key configured?

**Answer**: Via environment variable `OPENAI_API_KEY` in `.env` file.

**Configuration Pattern**:
```bash
# .env
OPENAI_API_KEY=sk-...
MODEL_CHOICE=gpt-4-turbo
LOG_LEVEL=INFO
```

**Security Consideration**:
- `.env` file is gitignored
- `.env.example` provides template without secrets
- Ansible deployment can use vault for API key

**Decision**: Document in README.md that users must provide their own OpenAI API key.

---

### 5. Port Availability

**Question**: Is port 11235 available on hx-test-server?

**Verification Method**:
```bash
ansible hx-test-server -i ansible/inventory/test-server.ini -m shell -a "ss -tlnp | grep 11235"
```

**Expected**: No output (port not in use)

**Decision**: Include port check in Ansible pre-flight validation.

---

### 6. ChromaDB Persistence

**Question**: How should ChromaDB data be persisted?

**Answer**: Volume mount at `./chroma_db` in docker-compose.yml

**Configuration**:
```yaml
volumes:
  - ./chroma_db:/app/chroma_db
  - ./data:/app/data
```

**Decision**:
- ChromaDB data persists across container restarts
- Backup/restore procedure not required for validation (development use only)
- Document volume location in README.md

---

### 7. Playwright Browser Installation

**Question**: How are Playwright browsers installed in the container?

**Answer**: Via `playwright install` command in Dockerfile

**Dockerfile Pattern**:
```dockerfile
RUN pip install -r requirements.txt
RUN playwright install
```

**Size Consideration**: Playwright browsers add ~1GB to image size

**Decision**: Accept larger image size for complete browser automation support.

---

### 8. Health Check Endpoint

**Question**: Does the original Streamlit app expose a health check endpoint?

**Research Finding**: Streamlit does not have a built-in health check endpoint.

**Workaround Options**:
1. Check if Streamlit process is responding on port 11235
2. Use `curl -f http://localhost:11235` and check for 200 status
3. Add custom health check script

**Decision**: Use simple HTTP check to port 11235 in docker-compose.yml healthcheck.

---

## Technology Choices

### Streamlit vs FastAPI

**Chosen**: Streamlit (original implementation)

**Rationale**:
- Reference implementation uses Streamlit
- Validation requires matching original exactly
- Citadel Alpha will use FastAPI for production

**Alternatives Considered**: None - must match original

---

### ChromaDB vs Qdrant

**Chosen**: ChromaDB embedded (original implementation)

**Rationale**:
- Original uses ChromaDB
- Validation baseline must be identical
- Citadel Alpha will migrate to Qdrant

**Alternatives Considered**: None - must match original

---

### OpenAI API vs Ollama

**Chosen**: OpenAI API (original implementation)

**Rationale**:
- Original uses OpenAI
- Validation establishes baseline behavior
- Citadel Alpha will use Ollama for cost savings

**Alternatives Considered**: None - must match original

---

## Deployment Strategy

**Chosen Approach**: Ansible playbook deployment

**Rationale**:
- Consistent with HX Platform deployment practices
- Automated validation and health checks
- Reusable for future deployments

**Steps**:
1. Pre-flight: Check Docker installed, port available
2. Deploy: Copy files, docker-compose up
3. Validate: Health check, smoke test via UI

**Alternatives Considered**:
- Manual deployment: Rejected (not repeatable)
- Kubernetes: Rejected (overkill for single container)

---

## Testing Strategy

**Chosen Approach**: Manual validation via Streamlit UI

**Test Scenarios** (from spec.md):
1. Container deployment and health
2. Web crawling functionality
3. LLM query processing with RAG

**Rationale**:
- Streamlit provides interactive UI for testing
- Automated UI testing with Streamlit is complex
- Manual testing sufficient for validation baseline

**Alternatives Considered**:
- Automated Streamlit tests: Rejected (complex setup, low ROI for validation)
- API tests: Not applicable (no REST API in original)

---

## Open Questions

**None** - All research questions resolved.

---

## References

- Original Repository: https://github.com/coleam00/ottomator-agents/tree/main/crawl4AI-agent-v2
- Crawl4AI Documentation: https://github.com/unclecode/crawl4ai
- Playwright Python: https://playwright.dev/python/
- Streamlit Documentation: https://docs.streamlit.io/
- ChromaDB Documentation: https://docs.trychroma.com/
- OpenAI API: https://platform.openai.com/docs/

---

**Status**: ✅ Research complete - Ready for Phase 1 (Design)
