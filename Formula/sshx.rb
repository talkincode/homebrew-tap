class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.18.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.18.0/sshx-darwin-arm64.tar.gz"
      sha256 "19f74724314933de5a7626c2666680d7981f0a5403ba2936106e843179099579"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.18.0/sshx-darwin-amd64.tar.gz"
      sha256 "b50e0f85b18510fed80c08b873f5ed5d7572869e3e4d9f290768742606bb515c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.18.0/sshx-linux-arm64.tar.gz"
      sha256 "62aabe533adea624862f707472468a1ff1dd489be10ee03070621c89808f0c76"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.18.0/sshx-linux-amd64.tar.gz"
      sha256 "f2c5708be9181683cde004f45f96f99c4669b1f23a76c27dcce7320fcb22d835"
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
