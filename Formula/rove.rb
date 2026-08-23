class Rove < Formula
  desc "Application network optimizer for Agent APIs and trading paths"
  homepage "https://github.com/talkincode/rove"
  url "https://github.com/talkincode/rove/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7d80678bfc1a81098280f1507ed463288245ac67c69c7ea728cfca2211decb06"
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
