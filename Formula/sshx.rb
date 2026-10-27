class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.20.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.20.1/sshx-darwin-arm64.tar.gz"
      sha256 "93d2a270de5394d8fbfb37ba2b573b372fff7d8daaa1b4131483cf2d5c60ece7"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.20.1/sshx-darwin-amd64.tar.gz"
      sha256 "04def184ad0ef5669d68617c336db9c1193c61f0e4b3e26b33f77f69a5b2b047"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.20.1/sshx-linux-arm64.tar.gz"
      sha256 "1a588b219f63148e1529b26ec64458951de92476bbbc910c0bddebec61fe75b8"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.20.1/sshx-linux-amd64.tar.gz"
      sha256 "f771a91a28c322f294192b147a8ddc278afaaa21970d2c936a7997079d38b8e3"
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
