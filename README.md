# OpenCode Credit — Homebrew tap

Homebrew cask for [OpenCode Credit](https://github.com/louisvolant/opencode-credit),
a tiny macOS menu bar app showing OpenCode Go usage windows and Zen credit.

```sh
brew install --cask louisvolant/opencode-statusbar/opencode-credit
```

Homebrew auto-taps this repository, so no separate `brew tap` is needed.

## Maintenance

`Casks/opencode-credit.rb` is refreshed automatically from the latest release of
`louisvolant/opencode-credit` by the `Update cask` workflow
(`scripts/update-cask.sh`). It runs daily and on demand (Actions → Update cask →
Run workflow).
