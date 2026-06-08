class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "a08e61fcd548e9509c72e52d761b62a41ecdde3ed3fb584fb2dd13d55cefcb50"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "d0f1c35d7b6eca6a80ef1262fe56a80fd8f1ecd76dbd2f03d519ff78228aa5e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "ddf96f5d4af0cd985cb995f814e5708e523bee4774eef9149f91052ee19d2c25"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "bcf869de3f5fc266263a7b6b2bb08c1a3f574b195e81c82294643b509d44ba40"
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
