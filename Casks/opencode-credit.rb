cask "opencode-credit" do
  version "1.0.10"
  sha256 "7ab1c6a31978726efcf10159d8099081a790ac67f763b8f0b74e9cd9da7b5593"

  url "https://github.com/louisvolant/opencode-credit/releases/download/v#{version}/OpenCodeCredit-#{version}.zip"
  name "OpenCode Credit"
  desc "Menu bar app showing OpenCode Go usage and Zen credit"
  homepage "https://github.com/louisvolant/opencode-credit"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "OpenCode Credit.app"

  caveats <<~EOS
    OpenCode Credit is not notarised by Apple, so macOS blocks the first
    launch. On macOS 15 and later, right-click -> Open is not always enough.

    Either open System Settings -> Privacy & Security and click "Open Anyway",
    or run:
      xattr -dr com.apple.quarantine "/Applications/OpenCode Credit.app"

    Alternatively, install the build-from-source formula, which is not
    quarantined (it compiles locally, so no Gatekeeper prompt):
      brew trust --formula louisvolant/opencode-statusbar/opencode-credit-src
      brew install --formula louisvolant/opencode-statusbar/opencode-credit-src
  EOS

  uninstall quit: "com.louisvolant.opencode-credit"

  zap trash: "~/Library/Preferences/com.louisvolant.opencode-credit.plist"
end
