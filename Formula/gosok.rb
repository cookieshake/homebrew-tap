class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "2920ec2f6a015bc486b9f78c11ad1714be951464a912dc9d8f9f7c8433682d3b"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "a5683f33bef1b463427cf564d561be746436434e3cbe8d9a0fe5eac1e4f80bc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "cf8ec26db68fceb9ece3cddd58e225370980d9cd241e15d25a78ed227d247028"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "74c687a607b10bd3dce9a459d8205b412118db221cd2f352f40209a1b52b67b9"
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
