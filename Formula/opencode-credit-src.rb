class OpencodeCreditSrc < Formula
  desc "Menu bar app showing OpenCode Go usage and Zen credit"
  homepage "https://github.com/louisvolant/opencode-credit"
  url "https://github.com/louisvolant/opencode-credit.git",
      tag:      "v1.0.5",
      revision: "5a64e844a4a2dcb164fcd66f8bb5ac807f999d2d"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :ventura

  def install
    system "./build.sh"
    prefix.install "build/OpenCode Credit.app"
  end

  def caveats
    <<~EOS
      The built app is not quarantined and launches without a Gatekeeper prompt.
      To use it (and to enable "Launch at login"), copy it to /Applications:
        cp -R "#{opt_prefix}/OpenCode Credit.app" /Applications/
    EOS
  end

  test do
    assert_path_exists prefix/"OpenCode Credit.app/Contents/MacOS/OpenCodeCredit"
  end
end
