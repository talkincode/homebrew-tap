class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.4.0/sshx-darwin-arm64.tar.gz"
      sha256 "e5c395bce7f8fd0789d5c7c15d0112dace570f2ed35ed724bae42eb2875e25a3"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.4.0/sshx-darwin-amd64.tar.gz"
      sha256 "c8496ae837f73b360e09687f3a533dea4bb80a8c2af3764f452c279c79a97d30"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.4.0/sshx-linux-arm64.tar.gz"
      sha256 "c6fec4f9fda693ce1969d8d92c03f8d0d053899236d19ddfc00b63c5781dc2e3"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.4.0/sshx-linux-amd64.tar.gz"
      sha256 "cb9b1aa6abe5889cde20f6470060d5e67c0d513d4c1664c43a11fa0c1beca5ae"
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
