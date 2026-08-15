class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.5.0/sshx-darwin-arm64.tar.gz"
      sha256 "a3e019b2a3d0cdc2e58901d7e64556f443f754b4ba3a668af329ec6f24fc80d4"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.5.0/sshx-darwin-amd64.tar.gz"
      sha256 "142ac8bd837e81d18c357829917e68741c04bf93d744a48bf558ba0683d792ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.5.0/sshx-linux-arm64.tar.gz"
      sha256 "6b0de6a69470c8a6059b07fd21f7e028fac6638be3c3d3e9ab9733c8a208c98b"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.5.0/sshx-linux-amd64.tar.gz"
      sha256 "9295783507d3455146314cb7a3334684a368d60ea8b825d4eb5f5b5c5566d8f9"
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
