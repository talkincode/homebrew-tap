class Sift < Formula
  desc "Cost-controlled open-source project auditor"
  homepage "https://github.com/talkincode/sift"
  version "0.4.1"
  license "MIT"
  depends_on :macos

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/sift/releases/download/v0.4.1/sift-v0.4.1-macos-arm64.tar.xz"
      sha256 "b188e6e0bde9265279655218625327cdf062a3cb8d238f2f9676b6d6eae975ad"
    else
      url "https://github.com/talkincode/sift/releases/download/v0.4.1/sift-v0.4.1-macos-amd64.tar.xz"
      sha256 "21afa4b2a203ba93055066c043498da452ad80f4d378c0d0eea783bd4ef93bc8"
    end
  end

  def install
    bin.install "sift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sift --version")
  end
end
