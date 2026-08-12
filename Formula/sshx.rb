class Sshx < Formula
  desc "Agent-native remote host execution over SSH"
  homepage "https://github.com/talkincode/sshx"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.1.0/sshx-darwin-arm64.tar.gz"
      sha256 "bbb4ca93be7727fa612ca4fba458f345b80b682971c70c4c03acbaa27d2888e0"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.1.0/sshx-darwin-amd64.tar.gz"
      sha256 "07b09473cbaaefe134d70ccadaff6c13d331eef746c4c7505366a62e2b46fce7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sshx/releases/download/v0.1.0/sshx-linux-arm64.tar.gz"
      sha256 "fd533042c462f5a2b20e158d8c9372aea494ce18b3b7e912ceef1485610ff5bb"
    else
      url "https://github.com/talkincode/sshx/releases/download/v0.1.0/sshx-linux-amd64.tar.gz"
      sha256 "ed3e55ef513752fabcece550d5a1ff2d348e96b9a65f511b330e80837e3045c1"
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
