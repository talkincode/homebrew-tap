class Rove < Formula
  desc "Application network optimizer for Agent APIs and trading paths"
  homepage "https://github.com/talkincode/rove"
  url "https://github.com/talkincode/rove/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e3348631c0019e2183e06bf7b92868f0151689ee69b6633ee50c6ddc2f86f2e4"
  license "MIT"
  head "https://github.com/talkincode/rove.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    assert_predicate bin/"rove", :exist?
    assert_predicate bin/"rove-hop", :exist?
  end
end
