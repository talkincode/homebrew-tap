class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.6.0/sshx-darwin-arm64.tar.gz"
      sha256 "db5563c343b6343fab90184cdf4e6bda4321ccbd28c3a098d080ab29f20f2cdb"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.6.0/sshx-darwin-amd64.tar.gz"
      sha256 "7172cdd30b7894aa5d7109386392823bf6c9ee2075c59fffee5d2102e84a3cc2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.6.0/sshx-linux-arm64.tar.gz"
      sha256 "e65a19cd7ad96a1bb54650597012486cd27a91307afa0b8e217343ebfe5f1d79"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.6.0/sshx-linux-amd64.tar.gz"
      sha256 "7c528125c26c6795f7e51b9c8f2df4fe8ab68ff22037dd5afb86b1291509b456"
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
