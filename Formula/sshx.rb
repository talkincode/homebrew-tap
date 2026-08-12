class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.2.0/sshx-darwin-arm64.tar.gz"
      sha256 "c48252535906fed0d0dbdaab26a65890be316ddbff0279b74943e817692b4b0f"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.2.0/sshx-darwin-amd64.tar.gz"
      sha256 "9e7ce5d4a24e94d7eaf843d653c656cefa97143d73f63e9bd82f95a3f1cbded7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.2.0/sshx-linux-arm64.tar.gz"
      sha256 "4fa3cb250c5ace03b770a9b8420ae806d707ee8949327341fa2f5098440f1e07"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.2.0/sshx-linux-amd64.tar.gz"
      sha256 "617c6d227247677f3dbd8a381c93652a12408c088a2850e36e76299915148a45"
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
