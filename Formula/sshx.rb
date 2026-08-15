class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.4.1/sshx-darwin-arm64.tar.gz"
      sha256 "8262e2630d410eb0b59c0f4c42b3ec4d86fba29262d052a5585ac919dea9e12b"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.4.1/sshx-darwin-amd64.tar.gz"
      sha256 "dc59dafc82a2573df686f0d8fc25a8b19e1865ab12ae36f449bbd06f4508ea8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.4.1/sshx-linux-arm64.tar.gz"
      sha256 "1829aa0682f3639f4cdb12af6621461e16a4b9ac21f1c6eb9ee8ec6c5e2cbd44"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.4.1/sshx-linux-amd64.tar.gz"
      sha256 "624285da7350f7b5d098cb8f330bfed5a5faea725fa909cb6eb7a9e1278b5d4b"
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
