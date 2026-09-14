class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.16.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.16.1/sshx-darwin-arm64.tar.gz"
      sha256 "059b1a4da5b6c9f14082c15bb443308abf88b87f25b095aedc8e7bd8d9c8804d"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.16.1/sshx-darwin-amd64.tar.gz"
      sha256 "3be759695045aead2043ca32703340a7e80a90d32fcf2d30b7e0bd881b56c756"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.16.1/sshx-linux-arm64.tar.gz"
      sha256 "7e03e621148d740b7793bf3ffc07497c4f47ed1765fdecb71cfbee62066e038d"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.16.1/sshx-linux-amd64.tar.gz"
      sha256 "8ca4802e7da513589c71ccf19640b2a4a78c116326f9d23501901979b9b3ef40"
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
