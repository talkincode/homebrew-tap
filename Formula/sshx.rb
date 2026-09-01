class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.13.0/sshx-darwin-arm64.tar.gz"
      sha256 "a8709c4a7171186ac438cedb54520e58d47fdeb51e48ed0eb8c54e0cbf4b73e7"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.13.0/sshx-darwin-amd64.tar.gz"
      sha256 "359eb6804dbf35797a95c94c942ca65047971c8944fe2e4ec1efa44525f9e18b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.13.0/sshx-linux-arm64.tar.gz"
      sha256 "bdfa96e1a35446fc9341252225750c52de84b9b907e914a11e65ffc35e7d060d"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.13.0/sshx-linux-amd64.tar.gz"
      sha256 "43d94c0973f599ae5874cf41dc2d81082ff7a87db96234021ed046f656f1f84e"
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
