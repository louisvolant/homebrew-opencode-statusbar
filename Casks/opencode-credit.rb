cask "opencode-credit" do
  version "1.0.1"
  sha256 "b22b5b9f797a1b4263dfde0582de2066bdb90baa1dbb9501c7e7fc6cbb414150"

  url "https://github.com/louisvolant/opencode-credit/releases/download/v#{version}/OpenCodeCredit-#{version}.zip"
  name "OpenCode Credit"
  desc "Menu bar app showing OpenCode Go usage and Zen credit"
  homepage "https://github.com/louisvolant/opencode-credit"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "OpenCode Credit.app"

  caveats <<~EOS
    OpenCode Credit is not notarised by Apple, so macOS refuses to launch it
    the first time. Right-click the app and choose "Open", or run:
      xattr -dr com.apple.quarantine "/Applications/OpenCode Credit.app"
  EOS

  zap trash: "~/Library/Preferences/com.louisvolant.opencode-credit.plist"
end
