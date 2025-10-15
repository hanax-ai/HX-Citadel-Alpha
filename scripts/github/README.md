# GitHub Automation Scripts

This directory contains automation scripts for setting up the HX-Citadel-Alpha project in GitHub.

## What Was Created

**✅ Complete GitHub Project Setup**:
- **Labels**: 19 labels for organization (phase, spec, priority, type, special)
- **Milestones**: 2 milestones (Spec 001 and Spec 002)
- **Issues**: 125 issues total
  - Spec 001: 35 issues (Crawl4AI Agent Validation)
  - Spec 002: 90 issues (Citadel Alpha HX Platform Integration)
- **Project Board**: All 125 issues added to https://github.com/users/hanax-ai/projects/1

## Scripts

### 01-setup-labels.sh
Creates all GitHub labels for the project.

**Labels created**:
- **Phase labels**: setup, tests, implementation, integration, polish, deployment, validation
- **Spec labels**: spec:001, spec:002
- **Priority labels**: critical, high, medium, low
- **Type labels**: task, test, documentation, deployment
- **Special labels**: parallel, tdd-gate, manual-test, hx-platform

**Usage**:
```bash
bash scripts/github/01-setup-labels.sh
```

### 02-setup-milestones.sh
Creates milestones for both specs.

**Milestones**:
- **Spec 001**: Crawl4AI Agent Validation (35 tasks, 4-6 hours, due 2025-10-17)
- **Spec 002**: Citadel Alpha HX Platform Integration (90 tasks, 9-12 days, due 2025-10-30)

**Usage**:
```bash
bash scripts/github/02-setup-milestones.sh
```

### 03-create-issues-spec001.sh
Creates all 35 issues for Spec 001: Crawl4AI Agent Validation.

**Issues created** (T001-T035):
- Phase 3.1: Setup (4 tasks)
- Phase 3.2: Pre-Deployment Validation (4 tasks)
- Phase 3.3: Docker Installation (4 tasks)
- Phase 3.4: Container Deployment (6 tasks)
- Phase 3.5: Health Validation (4 tasks)
- Phase 3.6: Manual Functional Testing (6 tasks)
- Phase 3.7: Regression Baseline Documentation (4 tasks)
- Phase 3.8: Validation Report (3 tasks)

**Usage**:
```bash
bash scripts/github/03-create-issues-spec001.sh
```

### 04-create-issues-spec002.sh
Creates issues T001-T049 for Spec 002: Citadel Alpha HX Platform Integration.

**Issues created** (T001-T049):
- Phase 3.1: Setup (5 tasks)
- Phase 3.2: Tests First - Contract Tests (10 tasks)
- Phase 3.2: Tests First - Integration Tests (6 tasks)
- Phase 3.2: TDD Gate (1 task - **CRITICAL**)
- Phase 3.3: Configuration Layer (4 tasks)
- Phase 3.3: Service Layer (5 tasks)
- Phase 3.3: API Models (2 tasks)
- Phase 3.3: API Routes (5 tasks)
- Phase 3.3: FastAPI Application (3 tasks)
- Phase 3.4: Integration (8 tasks)

**Usage**:
```bash
bash scripts/github/04-create-issues-spec002.sh
```

### 05-create-issues-spec002-part2.sh
Creates issues T050-T090 for Spec 002 (continuation).

**Issues created** (T050-T090):
- Phase 3.5: Unit Tests (3 tasks)
- Phase 3.5: Performance Tests (4 tasks)
- Phase 3.5: Documentation (3 tasks)
- Phase 3.5: Cleanup (3 tasks)
- Phase 3.6: Deployment & Validation (9 tasks)
- Phase 3.7: Open WebUI Integration (6 tasks)
- Phase 3.8: Comparison Testing (5 tasks)
- Phase 3.9: Final Validation (8 tasks)

**Usage**:
```bash
bash scripts/github/05-create-issues-spec002-part2.sh
```

### 06-add-issues-to-project.sh
Adds all 125 issues to the GitHub Project board.

**Project**: https://github.com/users/hanax-ai/projects/1

**Usage**:
```bash
bash scripts/github/06-add-issues-to-project.sh
```

## Complete Setup Process

To run the complete setup (already executed):

```bash
cd scripts/github

# 1. Create labels
bash 01-setup-labels.sh

# 2. Create milestones
bash 02-setup-milestones.sh

# 3. Create Spec 001 issues (35 issues)
bash 03-create-issues-spec001.sh

# 4. Create Spec 002 issues Part 1 (49 issues)
bash 04-create-issues-spec002.sh

# 5. Create Spec 002 issues Part 2 (41 issues)
bash 05-create-issues-spec002-part2.sh

# 6. Add all issues to project board (125 issues)
bash 06-add-issues-to-project.sh
```

## Authentication

These scripts require GitHub CLI authentication with a token that has:
- `repo` scope (full control of private repositories)
- `project` scope (manage projects)

**Set authentication**:
```bash
export GH_TOKEN="your_github_token_here"
```

Or use `gh auth login` interactively.

## Issue Organization

### Labels Guide

**Phase Labels** (indicate task phase):
- `phase:setup` - Initial setup and configuration
- `phase:tests` - Test creation (TDD)
- `phase:implementation` - Code implementation
- `phase:integration` - Service integration
- `phase:polish` - Cleanup, optimization, docs
- `phase:deployment` - Deployment tasks
- `phase:validation` - Testing and validation

**Priority Labels**:
- `priority:critical` - Blocking, must complete first
- `priority:high` - Important, complete soon
- `priority:medium` - Normal priority
- `priority:low` - Can be deferred

**Type Labels**:
- `type:task` - Standard implementation task
- `type:test` - Test creation or validation
- `type:documentation` - Documentation task
- `type:deployment` - Deployment task

**Special Labels**:
- `parallel` - Can run in parallel with other [P] tasks
- `tdd-gate` - TDD gate - blocks implementation until tests fail
- `manual-test` - Requires manual testing
- `hx-platform` - HX Platform integration task

### Milestones

**Spec 001: Crawl4AI Agent Validation**
- Duration: 4-6 hours
- Tasks: 35
- Purpose: Deploy and validate original Crawl4AI Agent as baseline

**Spec 002: Citadel Alpha HX Platform Integration**
- Duration: 9-12 days
- Tasks: 90
- Purpose: Production FastAPI container with HX Platform services

## Task Dependencies

### Spec 001 Dependencies
- **Sequential**: Most tasks are sequential (deployment workflow)
- **Parallel**: Documentation tasks (T029-T032) can run in parallel

### Spec 002 Dependencies
- **TDD Gate (T022)**: All implementation blocked until tests are failing
- **Parallel**: Many tasks marked [P] can run in parallel
  - Contract tests (T006-T015): All parallel
  - Integration tests (T016-T021): All parallel
  - Config modules (T023-T026): All parallel
  - Service modules (T027-T031): All parallel
  - API models (T032-T033): Parallel
  - Route files (T034, T036-T038): Parallel
- **Sequential**: Integration tasks (T042-T049) are sequential

## Project Board Workflow

Issues are added to the project board in the **Backlog** status. The typical workflow:

1. **Backlog** - All issues start here
2. **Todo** - Move when ready to work
3. **In Progress** - Move when actively working
4. **Done** - Move when completed and tested

GitHub Actions can automate status updates based on:
- Issue assignment → Move to Todo
- PR linked → Move to In Progress
- PR merged → Move to Done

## Metrics and Tracking

**Total Issues**: 125
- Spec 001: 35 issues (28%)
- Spec 002: 90 issues (72%)

**By Phase** (Spec 002):
- Setup: 5 tasks (6%)
- Tests (TDD): 17 tasks (19%)
- Implementation: 19 tasks (21%)
- Integration: 8 tasks (9%)
- Polish: 13 tasks (14%)
- Deployment: 9 tasks (10%)
- Open WebUI: 6 tasks (7%)
- Comparison: 5 tasks (6%)
- Final Validation: 8 tasks (9%)

**By Priority**:
- Critical: ~30 tasks
- High: ~50 tasks
- Medium: ~30 tasks
- Low: ~15 tasks

## Next Steps

1. **Start with Spec 001** (validation baseline)
2. **Complete T022 gate** in Spec 002 (ensure all tests fail)
3. **Follow TDD workflow** (tests before implementation)
4. **Use parallel execution** where marked [P]
5. **Update project board** as tasks complete
6. **Close milestones** when all tasks done

## References

- **Project Board**: https://github.com/users/hanax-ai/projects/1
- **Repository**: https://github.com/hanax-ai/HX-Citadel-Alpha
- **Task Templates**: `/projects/templates/tasks-template.md`
- **Spec Documentation**: `specs/001-crawl4ai-validation/` and `specs/002-citadel-alpha-integration/`

---

**Created**: 2025-10-15
**Total Setup Time**: ~10 minutes (automated)
**Issues Created**: 125
**Project Board**: Fully configured with real-time tracking
