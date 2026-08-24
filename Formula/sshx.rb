class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.10.0/sshx-darwin-arm64.tar.gz"
      sha256 "94122e6f1f3a30aa7c7d2ce1e31f1c7b99c3739d21d97698ff81183f1d336524"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.10.0/sshx-darwin-amd64.tar.gz"
      sha256 "af4cd4c29852b5a0b04b03ace287e6a9192681b156b2e0ff8e5f4922b73b24ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.10.0/sshx-linux-arm64.tar.gz"
      sha256 "5e71ea37fa6b50eb65a1d309a2c9706ecf565b82b9cc21d294d2a4707481b7d4"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.10.0/sshx-linux-amd64.tar.gz"
      sha256 "b600aa876a07b3bc78f9157450ff860331ddfe769f1028a7b8116d1d5737a227"
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
