class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "932ccd9949b53c1a7122b053220e29c8f40c46c04b5418a454bb3f2cd2f8ae7d"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "e2b32d2a97f8433898061cbd45a7f37e895bafd40946c9c4fa18a57277d23478"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "5211a45d67a9aa5e7610e6b33e1cd6c32632cc5a60980b3872042860c350fd98"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "050480843d7da967cb120080534ac3cbf8b02b95967116810d33d0a32dfb4fe7"
    end
  end

  def install
    bin.install Dir["gosok-*"].first => "gosok"
  end

  test do
    assert_match "gosok", shell_output("#{bin}/gosok --help 2>&1", 0..2)
  end
end
