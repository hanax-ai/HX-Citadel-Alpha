#!/bin/bash
# Setup GitHub labels for HX-Citadel-Alpha project
# Run this first to create labels before creating issues

set -e

REPO="hanax-ai/HX-Citadel-Alpha"

echo "Setting up labels for $REPO..."

# Phase labels
gh label create "phase:setup" --color "0E8A16" --description "Setup and initialization tasks" --repo $REPO || true
gh label create "phase:tests" --color "D93F0B" --description "Test creation (TDD)" --repo $REPO || true
gh label create "phase:implementation" --color "1D76DB" --description "Implementation tasks" --repo $REPO || true
gh label create "phase:integration" --color "5319E7" --description "Integration and wiring tasks" --repo $REPO || true
gh label create "phase:polish" --color "FBCA04" --description "Polish, optimization, documentation" --repo $REPO || true
gh label create "phase:deployment" --color "006B75" --description "Deployment and validation" --repo $REPO || true
gh label create "phase:validation" --color "C5DEF5" --description "Validation and testing" --repo $REPO || true

# Spec labels
gh label create "spec:001" --color "C2E0C6" --description "Spec 001: Crawl4AI Agent Validation" --repo $REPO || true
gh label create "spec:002" --color "BFDADC" --description "Spec 002: Citadel Alpha HX Platform Integration" --repo $REPO || true

# Priority labels
gh label create "priority:critical" --color "B60205" --description "Critical priority - blocking" --repo $REPO || true
gh label create "priority:high" --color "D93F0B" --description "High priority" --repo $REPO || true
gh label create "priority:medium" --color "FBCA04" --description "Medium priority" --repo $REPO || true
gh label create "priority:low" --color "0E8A16" --description "Low priority" --repo $REPO || true

# Type labels
gh label create "type:task" --color "1D76DB" --description "Standard task" --repo $REPO || true
gh label create "type:test" --color "D93F0B" --description "Test creation or validation" --repo $REPO || true
gh label create "type:documentation" --color "0075CA" --description "Documentation task" --repo $REPO || true
gh label create "type:deployment" --color "006B75" --description "Deployment task" --repo $REPO || true

# Special labels
gh label create "parallel" --color "C5DEF5" --description "Can run in parallel with other [P] tasks" --repo $REPO || true
gh label create "tdd-gate" --color "B60205" --description "TDD gate - blocks implementation" --repo $REPO || true
gh label create "manual-test" --color "FBCA04" --description "Requires manual testing" --repo $REPO || true
gh label create "hx-platform" --color "5319E7" --description "HX Platform integration" --repo $REPO || true

echo "✅ Labels created successfully!"
echo ""
echo "Next step: Run 02-setup-milestones.sh"
