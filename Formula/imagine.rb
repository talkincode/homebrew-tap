class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-macos-aarch64.tar.gz"
      sha256 "b52651dbc1a23c516498a41710db3608b00b993aba50ca1d62c4e073e71d1b2e"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-macos-x86_64.tar.gz"
      sha256 "8036d709627908dc4c724ae96e0a9e93356205a89f3b92cc67bdda5532c6e372"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-linux-aarch64.tar.gz"
      sha256 "0f765c6a91d8e16cac98278794623a4475c68af627beaff80daa95a35f72f2c9"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-linux-x86_64.tar.gz"
      sha256 "802c021a6cde43cfc628887b16a1e57e47d260ffd9dacd7f5291577462783cb8"
    end
  end

  def install
    bin.install Dir["imagine-*"].find { |f| File.file?(f) && File.executable?(f) } => "imagine"
    pkgshare.install "skills" if File.directory?("skills")
  end

  def caveats
    <<~EOS
      The agent skill has been installed to:
        #{opt_pkgshare}/skills/imagine

      To use it with your AI agent, link or copy it to your skills folder:
        mkdir -p ~/.agents/skills
        cp -R #{opt_pkgshare}/skills/imagine ~/.agents/skills/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/imagine version")
  end
end
