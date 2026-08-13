class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.3.0/sshx-darwin-arm64.tar.gz"
      sha256 "41b0fde352a58103ea18bfd6df4755b73e1dbfdef5316eee8e13654639935c09"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.3.0/sshx-darwin-amd64.tar.gz"
      sha256 "04a705e55d12d9c9d6e937cf4d5660ae28ab8f79c6bc5ea29b34555852142435"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.3.0/sshx-linux-arm64.tar.gz"
      sha256 "89b383eabf7fb10f5949f73160591a97c4673b99004dfac93b021a502ceb1260"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.3.0/sshx-linux-amd64.tar.gz"
      sha256 "1a2b597c32f63d20f601e439b9b7b22c2cee83d9191be49b8330a078d94b00d5"
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
