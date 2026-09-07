class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.15.0/sshx-darwin-arm64.tar.gz"
      sha256 "599145e2c4e6fb47be83172f4b7b42fe768aa952c6036721ded143cceb8d416c"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.15.0/sshx-darwin-amd64.tar.gz"
      sha256 "b7a366b8312e1ce91aca6fa2ce7b27367bada13f4c0aefb418cd95ee33f0d4cf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.15.0/sshx-linux-arm64.tar.gz"
      sha256 "56c1bbebc47b5783dd7abc06da763a0fef791a03a552833df22d82400ae8e895"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.15.0/sshx-linux-amd64.tar.gz"
      sha256 "fdad1ee25e547c1fbb01ed4d544ceeff811c2fc989cd5920523ed104a52fc257"
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
