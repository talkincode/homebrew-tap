class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.9.0/sshx-darwin-arm64.tar.gz"
      sha256 "dd9cf43d7a463d9368d2c284f422fbc781e568665621dec16e3868cc7176d27c"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.9.0/sshx-darwin-amd64.tar.gz"
      sha256 "6fa47032e0711932ad8c416bf96f90fbf8d3cb28fde1a674c51e58a5ff8f4c85"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.9.0/sshx-linux-arm64.tar.gz"
      sha256 "f7e3694c6fa0e106e898f91c94fcb762b01530070893b79a8e39958a0b8d9867"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.9.0/sshx-linux-amd64.tar.gz"
      sha256 "945cfc2d8d1b56ba38ae28c075ce1394ede985c68b8e0f78cf4aa17faddfa476"
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
