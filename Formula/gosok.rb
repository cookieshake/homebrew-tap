class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "3702be25d2a8cae50ae075cb032b21fdc5ac4b74d5afea7ad0a27685ce6ce472"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "dce36c7b79453968e4e9c0a1883227f455768e527b55027a82c7054388faae4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "b33fe4508c7d849ed1ee6a52eb2124b9979b407bb365d7a51682656cd7c3ca3b"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "8c66b372c13e6d3795660bc1bb720928200a4448a4b1b5eee925a333e6b08ea2"
    end
  end

  def install
    bin.install Dir["gosok-*"].first => "gosok"
  end

  test do
    assert_match "gosok", shell_output("#{bin}/gosok --help 2>&1", 0..2)
  end
end
