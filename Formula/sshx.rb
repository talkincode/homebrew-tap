class Sshx < Formula
  desc "Barrier-free SSH/SFTP CLI with a built-in OS-keyring password manager"
  homepage "https://github.com/talkincode/sshx"
  version "0.0.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.0.12/sshx-darwin-arm64.tar.gz"
      sha256 "4c45373fb4651ad9b26590cc109f490f0a6a63b6ba423580d2c86e97fdde79bb"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.0.12/sshx-darwin-amd64.tar.gz"
      sha256 "63de89750e267332285153edbe4b23e2c10c10d9d01b150ec38de10e28c3edc5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.0.12/sshx-linux-arm64.tar.gz"
      sha256 "6a5cb437d4b46ace5572d56f90f0c2eb7be76c9949934861f22ce4b38100df1c"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.0.12/sshx-linux-amd64.tar.gz"
      sha256 "7e09a9d837fce2b8477dfefe87eabd13b8df20748e32bd3a762f0239693b0b52"
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
