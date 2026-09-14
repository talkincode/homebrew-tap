class Sift < Formula
  desc "Cost-controlled open-source project auditor"
  homepage "https://github.com/talkincode/sift"
  version "0.4.0"
  license :cannot_represent
  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sift/releases/download/v0.4.0/sift-v0.4.0-macos-arm64.tar.xz"
      sha256 "86b9df949abb97449387cdfd6f074764eb0d8d5e67aba1295f8d8392b3e12383"
    else
      url "https://github.com/talkincode/sift/releases/download/v0.4.0/sift-v0.4.0-macos-amd64.tar.xz"
      sha256 "a03904de0052ca8d3cb916bf56bb3a70badc4058055b19dcb41c6fd1af0c1f6a"
    end
  end

  def install
    bin.install "sift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sift --version")
  end
end
