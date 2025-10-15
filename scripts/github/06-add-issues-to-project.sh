#!/bin/bash
# Add all GitHub issues to project board
# Project: https://github.com/users/hanax-ai/projects/1

set -e

REPO="hanax-ai/HX-Citadel-Alpha"
PROJECT_NUMBER=1
OWNER="hanax-ai"

echo "Adding all issues from $REPO to Project #$PROJECT_NUMBER..."

# Get project ID
PROJECT_ID=$(gh api graphql -f query='
  query {
    user(login: "'$OWNER'") {
      projectV2(number: '$PROJECT_NUMBER') {
        id
      }
    }
  }
' --jq '.data.user.projectV2.id')

echo "Project ID: $PROJECT_ID"

# Get all issues
ISSUES=$(gh issue list --repo $REPO --limit 200 --json number --jq '.[].number')

count=0
for issue_number in $ISSUES; do
  echo "Adding issue #$issue_number to project..."

  # Get issue node ID
  ISSUE_ID=$(gh api graphql -f query='
    query {
      repository(owner: "hanax-ai", name: "HX-Citadel-Alpha") {
        issue(number: '$issue_number') {
          id
        }
      }
    }
  ' --jq '.data.repository.issue.id')

  # Add issue to project
  gh api graphql -f query='
    mutation {
      addProjectV2ItemById(input: {projectId: "'$PROJECT_ID'", contentId: "'$ISSUE_ID'"}) {
        item {
          id
        }
      }
    }
  ' > /dev/null

  count=$((count + 1))
  echo "  ✓ Added issue #$issue_number ($count issues added)"
done

echo ""
echo "✅ Successfully added $count issues to project board!"
echo ""
echo "View project: https://github.com/users/$OWNER/projects/$PROJECT_NUMBER"
