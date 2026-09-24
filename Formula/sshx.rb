class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.19.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.19.0/sshx-darwin-arm64.tar.gz"
      sha256 "f7e9dc801bf4e855cb77edeb10495247f9c711b7d8d55ee31b17047e374f48dc"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.19.0/sshx-darwin-amd64.tar.gz"
      sha256 "90ac4b11fd887d1fcc0470d27214878b421381a39f2c348d1221ee269d81fda3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.19.0/sshx-linux-arm64.tar.gz"
      sha256 "ea5e66926b72d02450d3e9c6a201c4f4f6a794f81e7f3b3aeb34c3f6be7dfa1e"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.19.0/sshx-linux-amd64.tar.gz"
      sha256 "680f18a13248abeda923fc1265dbaf7f557280df3c2473cfc4d035940c599f58"
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
