#!/usr/bin/env bash
# Create or update the team's standard labels in one or more repos.
# Templates only apply labels that already exist in the repo, so run this
# on every repo that uses the org templates.
#
# Usage:
#   ./scripts/sync-labels.sh DHS-OEDA/repo-one DHS-OEDA/repo-two
#   ./scripts/sync-labels.sh --all DHS-OEDA      # every non-archived repo in the org
#
# Requires: GitHub CLI (gh), authenticated with write access to the repos.

set -euo pipefail

LABELS_FILE="$(dirname "$0")/labels.tsv"

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 OWNER/REPO [OWNER/REPO ...]  |  $0 --all ORG" >&2
  exit 1
fi

if [[ "$1" == "--all" ]]; then
  ORG="${2:?Provide an org name after --all}"
  mapfile -t REPOS < <(gh repo list "$ORG" --no-archived --limit 1000 --json nameWithOwner -q '.[].nameWithOwner')
else
  REPOS=("$@")
fi

for repo in "${REPOS[@]}"; do
  echo "→ $repo"
  tail -n +2 "$LABELS_FILE" | while IFS=$'\t' read -r name color description; do
    [[ -z "$name" ]] && continue
    gh label create "$name" --repo "$repo" --color "$color" --description "$description" --force >/dev/null \
      && echo "   ✓ $name" \
      || echo "   ✗ $name (failed)" >&2
  done
done
