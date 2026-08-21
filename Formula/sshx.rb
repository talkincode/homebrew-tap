class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.8.0/sshx-darwin-arm64.tar.gz"
      sha256 "43f2bf9e6e4b251c04417c2db3c819999730e192b796a65777d9ae271132192a"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.8.0/sshx-darwin-amd64.tar.gz"
      sha256 "d0aec7b88d660aa57e234c549331320ee8183581027b345d29a248f0450b1722"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.8.0/sshx-linux-arm64.tar.gz"
      sha256 "cb1b92ddbd2a93b580985b256ba2e4a58cb255dd9597871b0c64e973884a1411"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.8.0/sshx-linux-amd64.tar.gz"
      sha256 "902b6100acd8eea0e5e003a6dbef5580c97cb8047d0e40a91aaf39591e21b49d"
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
