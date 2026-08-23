class Rove < Formula
  desc "Application network optimizer for Agent APIs and trading paths"
  homepage "https://github.com/talkincode/rove"
  url "https://github.com/talkincode/rove/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a25a4518b15885c7aa69fb73001a9684f4f2b9ef5f70404150985ff666db64c3"
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
