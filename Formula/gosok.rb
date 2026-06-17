class Gosok < Formula
  desc "Web-based terminal multiplexer with project and tab management"
  homepage "https://github.com/cookieshake/gosok-terminal"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-arm64"
      sha256 "932e0241e50eab435635ce816eb2aa7cce5a02762084203d1ad9086a626178ed"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-darwin-amd64"
      sha256 "4c5aa72d2fa36b4ac5908048bd04f9f8ff5d9cfc256eae4bc40f109a47fee88d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-arm64"
      sha256 "5e175103e70a651df462f9adab1055310a1e364eae09ce9667950e594a331ded"
    end
    on_intel do
      url "https://github.com/cookieshake/gosok-terminal/releases/download/v#{version}/gosok-linux-amd64"
      sha256 "7678dcf5acfe949ac6130e74b2c8f6817633bf8a2522b9280a8c519c16fb2d95"
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
