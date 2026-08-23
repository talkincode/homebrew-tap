class Rove < Formula
  desc "Application network optimizer for Agent APIs and trading paths"
  homepage "https://github.com/talkincode/rove"
  version "0.1.0"
  license "MIT"

  on_macos do
    url "https://github.com/talkincode/rove/releases/download/v0.1.0/rove-darwin-arm64.tar.gz"
    sha256 "1d6f29d3a97fa8abe6421bf6c5d0d685fb6e4d11ec7f8993f35626a9db6f4157"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/rove/releases/download/v0.1.0/rove-linux-arm64.tar.gz"
      sha256 "033c34b1fe37b2770d3bf02a0dd30b1ee567eefd7fb6fdf3e7c84afb1be01159"
    else
      url "https://github.com/talkincode/rove/releases/download/v0.1.0/rove-linux-amd64.tar.gz"
      sha256 "de073d4e643881921cdad1d8b74ce743db68e5cc569121578e278ed59fbf304f"
    end
  end

  def install
    bin.install "rove"
    bin.install "rove-hop"
    bin.install "rove-relay"
    bin.install "rove-abctl"
  end

  test do
    assert_predicate bin/"rove", :exist?
  end
end
