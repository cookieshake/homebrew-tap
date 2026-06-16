class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "26c8a21e801ca9302a772978bdfe3392ce2caff918126cf719e2d2e6ce7d2109"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "51406b68dbeada7b2260345b5a60f9bfdc4d572364665bf00de5df9e2b088d6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "7c8d9452fc957a040409a76d3df1dd55d648267ceeb0f3a432432118fb639aa2"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "afd7f58876543a2cb24d72b34137a2501b0937ae6cc50ea0ed575469a42a7a9f"
    end
  end

  def install
    bin.install Dir["gosok-*"].first => "gosok"

    (bin/"gosok-launcher").write <<~EOS
      #!/bin/bash
      if [ -f "$HOME/.gosok/env" ]; then
        set -a
        . "$HOME/.gosok/env"
        set +a
      fi
      exec #{opt_bin}/gosok "$@"
    EOS
    chmod 0755, bin/"gosok-launcher"

    pkgshare.mkpath
    (pkgshare/"env.example").write <<~EOS
      # Copy to ~/.gosok/env and edit, then: brew services restart gosok
      #
      # GOSOK_PORT=18435
      # GOSOK_DB_PATH=$HOME/.gosok/gosok.db
      # GOSOK_API_URL=http://localhost:18435
    EOS
  end

  service do
    run [opt_bin/"gosok-launcher"]
    keep_alive true
    log_path var/"log/gosok.log"
    error_log_path var/"log/gosok.log"
  end

  def caveats
    <<~EOS
      To customize the port or other settings:
        mkdir -p ~/.gosok
        cp #{opt_pkgshare}/env.example ~/.gosok/env
        $EDITOR ~/.gosok/env
        brew services restart gosok

      Default port: 18435. Database: ~/.gosok/gosok.db.
    EOS
  end

  test do
    assert_match "gosok", shell_output("#{bin}/gosok --help 2>&1", 0..2)
  end
end
