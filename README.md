# OpenCode Credit — Homebrew tap

Homebrew cask and formula for
[OpenCode Credit](https://github.com/louisvolant/opencode-credit), a tiny macOS
menu bar app showing OpenCode Go usage windows and Zen credit.

Homebrew auto-taps this repository, so no separate `brew tap` is needed.

## Install

Prebuilt app (recommended):

```sh
brew install --cask louisvolant/opencode-statusbar/opencode-credit
```

The app is **not notarised** by Apple, so macOS blocks the first launch. Either
open **System Settings → Privacy & Security → "Open Anyway"**, or run:

```sh
xattr -dr com.apple.quarantine "/Applications/OpenCode Credit.app"
```

Build from source (compiles locally, so the app is **not quarantined** and there
is no Gatekeeper prompt; requires the Command Line Tools):

```sh
brew trust --formula louisvolant/opencode-statusbar/opencode-credit-src
brew install --formula louisvolant/opencode-statusbar/opencode-credit-src
```

Homebrew 7 requires trusting third-party tap formulae before loading them; the
cask does not need this. The formula installs the app under the Homebrew prefix;
copy it to `/Applications` to use it from the menu bar and to enable "Launch at
login".

## Maintenance

`Casks/opencode-credit.rb` and `Formula/opencode-credit-src.rb` are refreshed
automatically from the latest release of `louisvolant/opencode-credit` by the
`Update cask and formula` workflow (`scripts/update.sh`). It runs daily and on
demand (Actions → Update cask and formula → Run workflow).
