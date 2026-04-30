class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "c935c37e85889756a079148cb651c5e6d7259d21736106ecde59ed10f085b59b"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "5a607f52f44d45aead855e2bc35d20a95fe6fcb57f4dc419ee6fd6cdbe219045"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "9d1e298488eb2b83fb69f3c8215fbb48c9bc1e763e4314a6498f9d20b08391b1"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "3ba599cb61be7a4ad3d74ae43cfeba598c225b29726ed54c8990910a87555fa8"
    end
  end

  def install
    bin.install Dir["gosok-*"].first => "gosok"
  end

  test do
    assert_match "gosok", shell_output("#{bin}/gosok --help 2>&1", 0..2)
  end
end
