#!/usr/bin/env bash
#
# Refreshes the tap from the latest GitHub release of the app repository:
#   * Casks/opencode-credit.rb   — bumps `version` and recomputes `sha256`
#   * Formula/opencode-credit.rb — bumps the git `tag` and `revision`
#
# Used by the `Update cask and formula` workflow. Requires an authenticated
# `gh` (the workflow provides GITHUB_TOKEN through GH_TOKEN).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CASK="$ROOT/Casks/opencode-credit.rb"
FORMULA="$ROOT/Formula/opencode-credit-src.rb"
REPO="${APP_REPO:-louisvolant/opencode-credit}"

tag="$(gh release view --repo "$REPO" --json tagName --jq .tagName)"
version="${tag#v}"
revision="$(gh api "repos/$REPO/commits/$tag" --jq .sha)"

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

tmp="$(mktemp)"
awk -v tag="$tag" -v revision="$revision" '
  /^      tag: /      { print "      tag:      \"" tag "\"";        next }
  /^      revision: / { print "      revision: \"" revision "\""; next }
  { print }
' "$FORMULA" > "$tmp"
mv "$tmp" "$FORMULA"

echo "Updated Casks/opencode-credit.rb to ${version} (sha256 ${sha})"
echo "Updated Formula/opencode-credit-src.rb to ${tag} (revision ${revision})"
