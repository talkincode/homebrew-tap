class Sshx < Formula
  desc "Barrier-free SSH/SFTP CLI with a built-in OS-keyring password manager"
  homepage "https://github.com/talkincode/sshx"
  version "0.0.13"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.0.13/sshx-darwin-arm64.tar.gz"
      sha256 "f32bd9932b6d479c7eb7eb02c2c0854e238e3b3476373a8c3b678d22d79a78e4"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.0.13/sshx-darwin-amd64.tar.gz"
      sha256 "8c5ee22117ffd7f6b918b3c89fb75738b2ae93967da7ea5badb1604953265da0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.0.13/sshx-linux-arm64.tar.gz"
      sha256 "1557d5dc6a795f0f2fc11199402dc669f28eba46dbc418a57f6e39cab1d7e292"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.0.13/sshx-linux-amd64.tar.gz"
      sha256 "0da5ee86f36df90e99138890df83c26f221d637cf371216b9a448016c34fe00c"
    end
  end

  def install
    # Each archive contains a single, platform-suffixed binary
    # (e.g. sshx-darwin-arm64); rename it to the plain "sshx" command.
    bin.install Dir["sshx-*"].first => "sshx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sshx --version")
  end
end
