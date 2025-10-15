#!/bin/bash
# Setup GitHub milestones for HX-Citadel-Alpha project

set -e

REPO="hanax-ai/HX-Citadel-Alpha"

echo "Setting up milestones for $REPO..."

# Spec 001 milestone
gh api repos/$REPO/milestones -f title="Spec 001: Crawl4AI Agent Validation" \
  -f description="Deploy and validate original Crawl4AI Agent container as baseline reference. 35 tasks, 4-6 hours estimated." \
  -f due_on="2025-10-17T23:59:59Z" \
  -f state="open" || echo "Milestone already exists"

# Spec 002 milestone
gh api repos/$REPO/milestones -f title="Spec 002: Citadel Alpha HX Platform Integration" \
  -f description="Production-ready FastAPI container with Ollama, Qdrant, Redis integration. 90 tasks, 9-12 days estimated." \
  -f due_on="2025-10-30T23:59:59Z" \
  -f state="open" || echo "Milestone already exists"

echo "✅ Milestones created successfully!"
echo ""
echo "Next step: Run 03-create-issues-spec001.sh"
