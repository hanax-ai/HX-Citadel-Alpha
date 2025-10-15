# Implementation Plan: Crawl4AI Agent Validation

**Branch**: `001-crawl4ai-validation` | **Date**: 2025-10-15 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-crawl4ai-validation/spec.md`

## Summary

Deploy and validate the original Crawl4AI Agent container (unmodified from ottomator-agents/crawl4AI-agent-v2) on hx-test-server to establish a working baseline for regression testing against the modified Citadel Alpha implementation.

## Technical Context

**Language/Version**: Python 3.11
**Primary Dependencies**: crawl4ai==0.6.2, playwright==1.52.0, streamlit==1.45.0, openai==1.76.2, chromadb==1.0.7
**Storage**: ChromaDB embedded (volume-mounted at ./chroma_db)
**Testing**: Manual validation tests, Ansible deployment tests
**Target Platform**: Docker container on Ubuntu 24.04 (hx-test-server)
**Project Type**: Single container deployment
**Performance Goals**: Page crawl <30s, embedding generation <5s, query response <10s
**Constraints**: Requires OpenAI API key, port 11235 available, Docker installed
**Scale/Scope**: Single-user development deployment, reference implementation only

## Constitution Check

✅ **TDD Required**: Manual validation tests documented in spec.md
✅ **Spec-Driven Development**: spec.md completed and approved
✅ **Container-First**: Docker container is primary deliverable
✅ **HX Platform Integration**: N/A - this is reference implementation
✅ **No Modifications**: Source code copied as-is from ottomator-agents

**No Constitution violations** - This is a validation/baseline task, not new development.

## Project Structure

### Documentation (this feature)
```
specs/001-crawl4ai-validation/
├── spec.md              # Feature specification (complete)
├── plan.md              # This file
├── research.md          # Source location, dependencies
├── contracts/           # N/A - Streamlit UI, no API contracts
└── tasks.md             # Implementation tasks (TDD workflow)
```

### Source Code (repository)
```
containers/crawl4ai-agent/
├── src/                 # Copied from ottomator-agents
│   └── streamlit_app.py # Main Streamlit application
├── Dockerfile           # Python 3.11 + Playwright
├── docker-compose.yml   # Port 11235, ChromaDB volume
├── requirements.txt     # Python dependencies
├── .env.example         # OpenAI API configuration template
└── README.md            # Reference documentation
```

**Structure Decision**: Single container deployment with Streamlit UI. No backend/frontend separation needed. Source code will be copied from `/home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/` without modifications.

## Phase 0: Outline & Research

**Research Tasks**:
1. Verify source location and completeness
2. Document original dependencies and versions
3. Identify Docker role location for Ansible deployment
4. Test OpenAI API key availability

**Output**: research.md with source verification and deployment prerequisites

## Phase 1: Design & Contracts

**N/A for this feature** - This is a reference deployment, not new development.

**Activities**:
1. **Copy source code** from ottomator-agents to `containers/crawl4ai-agent/src/`
2. **Verify Dockerfile** matches original requirements
3. **Document deployment process** in README.md
4. **Create manual test plan** for validation

**No API contracts** - Streamlit provides built-in UI, no REST API needed for validation.

**Output**: Source code copied, deployment documentation updated

## Phase 2: Task Planning Approach

**Task Generation Strategy**:
- **Setup tasks**: Copy source code, verify Docker role, configure Ansible inventory
- **Deployment tasks**: Run Ansible playbook, verify container health
- **Validation tasks**: Manual testing via Streamlit UI (documented in spec.md)

**Ordering Strategy**:
1. Copy source code and verify completeness
2. Ensure Docker installed on hx-test-server (via existing Docker role)
3. Deploy container using Ansible
4. Validate functionality via manual tests

**Estimated Output**: 8-10 sequential tasks (no parallelization needed for deployment)

## Phase 3+: Future Implementation

**Phase 3**: Generate tasks.md with deployment and validation steps
**Phase 4**: Execute tasks (copy source, deploy via Ansible, validate)
**Phase 5**: Document validation results, compare against Citadel Alpha later

## Complexity Tracking

**No complexity deviations** - This is a straightforward container deployment of existing software.

## Progress Tracking

**Phase Status**:
- [x] Phase 0: Research (source location verified)
- [ ] Phase 1: Design (copy source code)
- [ ] Phase 2: Task planning (describe approach) - Ready for tasks.md generation
- [ ] Phase 3: Tasks generated
- [ ] Phase 4: Implementation (deployment)
- [ ] Phase 5: Validation (manual tests)

**Gate Status**:
- [x] Initial Constitution Check: PASS (validation task, not new development)
- [ ] Post-Design Constitution Check: PASS (pending source copy)
- [ ] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented: NONE

---
*Based on HX-Citadel-Alpha CONSTITUTION.md*
