class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.7.0/sshx-darwin-arm64.tar.gz"
      sha256 "01fa7bb6d997fc23d2ddbdc27375a3df23810090f5af7164da19d1ccde35f581"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.7.0/sshx-darwin-amd64.tar.gz"
      sha256 "419ee9d47c18d62e75ea4016a8af3a144e4be98e7e790cff148c9bb6865afba8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.7.0/sshx-linux-arm64.tar.gz"
      sha256 "fc26cc7ff31b83b7215ebfd65ff51a671757865fbfd3c78680fa746d674e9fe1"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.7.0/sshx-linux-amd64.tar.gz"
      sha256 "46a5a69add4c95c500ca29e43f64d2826345686f85b7994ef9462a6c50fd5615"
    end
  end

  def install
    # Each archive contains a single, platform-suffixed binary
    # (e.g. sshx-darwin-arm64); rename it to the plain "sshx" command.
    bin.install Dir["sshx-*"].first => "sshx"
  end

  def caveats
    <<~EOS
      Install or update the matching Agent skill after installation:
        sshx skill install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sshx --version")
    output = shell_output("#{bin}/sshx skill install --dir=#{testpath}/skills/sshx --json --no-audit")
    assert_match '"status":"installed"', output
    assert_predicate testpath/"skills/sshx/SKILL.md", :exist?
  end
end
