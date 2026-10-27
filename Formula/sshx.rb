class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.20.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.20.0/sshx-darwin-arm64.tar.gz"
      sha256 "71a601d8506c2e434ec6ee292114fe14842f5daca2870f84048f79608e8d71b7"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.20.0/sshx-darwin-amd64.tar.gz"
      sha256 "6c5466294efb1202a1d764ed9af02253d1870a78640dae05dc85f0e76288fb46"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.20.0/sshx-linux-arm64.tar.gz"
      sha256 "6d7889f2d7bbd3468ff357593c698d3fe330054be896ba4de2fc93b4d8987687"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.20.0/sshx-linux-amd64.tar.gz"
      sha256 "6b4e00157d42c318ecaa7c0a773c54fd387c832eccfdba9ff37f4f07cbcfa172"
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
