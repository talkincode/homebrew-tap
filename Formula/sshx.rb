class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.11.0/sshx-darwin-arm64.tar.gz"
      sha256 "9c5efe22eebe73fb60fc3935889eca29583eb12b64b2b129f6d73fbf5ff4c7ec"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.11.0/sshx-darwin-amd64.tar.gz"
      sha256 "34829d888bb07342b4ec9b5e80897eae772025ebcaf480b6890c544efddbae07"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.11.0/sshx-linux-arm64.tar.gz"
      sha256 "47b4ec258609d35c925351a79e1cd95f4f01c29593af6f8355f54b0a22b22dc3"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.11.0/sshx-linux-amd64.tar.gz"
      sha256 "1aad506e27eb984f42dd50cd58a46d2477af8b40d073f0750476af6ab2edeb1d"
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
