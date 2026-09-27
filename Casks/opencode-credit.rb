cask "opencode-credit" do
  version "1.0.4"
  sha256 "a324ff4ff6526101eab8b9b589e3872f200680814a05e55c43aa37e68f02e7cf"

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
