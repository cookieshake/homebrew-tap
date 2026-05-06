class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "e01505c1c0aa7715b6e158955c7e8e926d7319db99a709fb6b1fe105bb9ab2aa"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "f3a313c16123a0048c7bcfeed65fb0a8598062cf445cc779ff885bd7568b3876"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "db4a1098b2a7b2ac720110efe517520a08f7ddc3ecae1cb7e0d8cb07bc4ca08b"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "b25d3f4aeba4b455a8252fe521df5e277f8be7971c1d5af7a60e1eb8083a7203"
    end
  end

  def install
    bin.install Dir["gosok-*"].first => "gosok"
  end

  test do
    assert_match "gosok", shell_output("#{bin}/gosok --help 2>&1", 0..2)
  end
end
