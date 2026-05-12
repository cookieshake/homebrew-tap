class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "e7b8bb0035e65054c894782b80690e04ca1ec0365c31ae6fdfa0c32322dc8150"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "e23a72b28aa6776ee5dba17dd04eb62d5cf4fbd0c373bd48aea5ad28d6a20fdd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "13688b135b66e1f0a928c4305ef14f0cd56a85f66458b2f09744e452f2bedf8b"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "5aa89a2e6d77697b0306297b41fb9cac5e84096652173d868e4e5320fb0e99e3"
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
