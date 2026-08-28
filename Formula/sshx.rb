class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.12.0/sshx-darwin-arm64.tar.gz"
      sha256 "7e05978ae42e509aa46ff1754e353b1db6af31fc7ef95727a73138d4cc557cf5"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.12.0/sshx-darwin-amd64.tar.gz"
      sha256 "478e42ef7caf481b1bd7dec89f561015b8490f7a6e6574ea295b70156fe532bd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.12.0/sshx-linux-arm64.tar.gz"
      sha256 "d56352af2bc1d80c4101428249228e9c389c41520715d0f9c0283340d751dda1"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.12.0/sshx-linux-amd64.tar.gz"
      sha256 "3ffdc9bed5760e8e48297ad8561b4417b613324d6e532c7f00faafde195d24f1"
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
