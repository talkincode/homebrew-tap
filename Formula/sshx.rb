class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.17.0/sshx-darwin-arm64.tar.gz"
      sha256 "a4c5f65d6e268ea51bc055edfa7952ead72bafd2870d6671b40977bf08dff3e8"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.17.0/sshx-darwin-amd64.tar.gz"
      sha256 "e3daa5374469343656d527c806410a48c844fef9affb7fd624f91af6eb5826be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.17.0/sshx-linux-arm64.tar.gz"
      sha256 "a937797b1138c62b21003ca9670d849fca9cafa54e27da19b6f076a4472f1794"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.17.0/sshx-linux-amd64.tar.gz"
      sha256 "322b05d57c554bb767bf75c419606cd21d5b3390cdac9a4cceeb29b0bbfab75a"
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
