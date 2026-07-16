class Sshx < Formula
  desc "Barrier-free SSH/SFTP CLI with a built-in OS-keyring password manager"
  homepage "https://github.com/talkincode/sshx"
  version "0.0.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.0.14/sshx-darwin-arm64.tar.gz"
      sha256 "6814cc13c043cbcc06e7cf0fa040fdbf46353281f76dfb43b127c1934280132a"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.0.14/sshx-darwin-amd64.tar.gz"
      sha256 "f011bfaaa9317886b90f80179a969a9892aceac9b264d40e74c09930786655f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.0.14/sshx-linux-arm64.tar.gz"
      sha256 "13b41e2ec9f92e0dd917fabf8e480d62380dc0a539d63d326d4cebb57d1b5205"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.0.14/sshx-linux-amd64.tar.gz"
      sha256 "ef02d9de8531d644b2292f7573cc825fb0d842914f6d3de0fbb882906acd592f"
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
