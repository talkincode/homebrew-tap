class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.16.0/sshx-darwin-arm64.tar.gz"
      sha256 "855df179773343aa6c18d6bb4c00f6a8016194f2822da95be5028751deaf1f92"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.16.0/sshx-darwin-amd64.tar.gz"
      sha256 "b6ea016e5db7c2b82f7419414d2a7a4a77bbeaacd7b74fab6ecc018cfe8fb81c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.16.0/sshx-linux-arm64.tar.gz"
      sha256 "c73af4589954aac6de763dc09641f893255990796a7de2dd339f5f255904e2aa"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.16.0/sshx-linux-amd64.tar.gz"
      sha256 "251de7eab8cf61627da57c7ea55ea7817be06f37677dfa62cb22f4e5c8454645"
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
