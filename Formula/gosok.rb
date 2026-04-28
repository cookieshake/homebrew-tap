class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "488fd37ca707112156fca79ba525015ad4647be00ed980a97ee3367dd4ccde74"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "298637a07392fbdab93c557c72cbe0fe38e9ab5a03274d5c253459032368e588"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "eb5fc0280ef9122ec905e9b68ec4e1d0ea720fd1e772eb47fbbf83e125f8ec34"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "9d8d6914e71a45b6b2e7d4c860fd924b33dbc0c86433a1d872377b646873ad5c"
    end
  end

  def install
    bin.install Dir["gosok-*"].first => "gosok"
  end

  test do
    assert_match "gosok", shell_output("#{bin}/gosok --help 2>&1", 0..2)
  end
end
