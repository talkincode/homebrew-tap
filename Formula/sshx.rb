class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.19.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.19.1/sshx-darwin-arm64.tar.gz"
      sha256 "b49908cd4fab52c997176302ed224118b8ad46397635d8dc6c66ef1e6af7c3ba"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.19.1/sshx-darwin-amd64.tar.gz"
      sha256 "135678c43e9829b1ba4f6ed7a0479a0b09a056732fa240856374a4d8cef0f933"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.19.1/sshx-linux-arm64.tar.gz"
      sha256 "44af8572ac22d18694c376e1a3b6864ba51b26c4ad216ecae7460359dc8e20a4"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.19.1/sshx-linux-amd64.tar.gz"
      sha256 "8a6cdffec0f01fec4112f3f34e9f5070a84504bd197a5e497af53086ae941a67"
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
