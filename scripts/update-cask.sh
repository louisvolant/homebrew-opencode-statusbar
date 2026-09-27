#!/usr/bin/env bash
#
# Refreshes Casks/opencode-credit.rb from the latest GitHub release of the app
# repository: bumps `version` and recomputes `sha256` from the release zip.
#
# Used by the `Update cask` workflow. Requires an authenticated `gh` (the
# workflow provides GITHUB_TOKEN through GH_TOKEN).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CASK="$ROOT/Casks/opencode-credit.rb"
REPO="${APP_REPO:-louisvolant/opencode-credit}"

tag="$(gh release view --repo "$REPO" --json tagName --jq .tagName)"
version="${tag#v}"

url="https://github.com/${REPO}/releases/download/${tag}/OpenCodeCredit-${version}.zip"

# GNU coreutils on the CI runner, BSD shasum on macOS.
if command -v sha256sum >/dev/null 2>&1; then
  sha="$(curl -fsSL "$url" | sha256sum | awk '{print $1}')"
else
  sha="$(curl -fsSL "$url" | shasum -a 256 | awk '{print $1}')"
fi

tmp="$(mktemp)"
awk -v version="$version" -v sha="$sha" '
  /^  version / { print "  version \"" version "\""; next }
  /^  sha256 /  { print "  sha256 \"" sha "\"";     next }
  { print }
' "$CASK" > "$tmp"
mv "$tmp" "$CASK"

echo "Updated $(basename "$CASK") to ${version} (sha256 ${sha})"
