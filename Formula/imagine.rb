class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.6.0/imagine-macos-aarch64.tar.gz"
      sha256 "e510a7c6c0ea4f4867e96c3d4af188a81d1dfde14d4b7895d0ae05c6f306bebe"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.6.0/imagine-macos-x86_64.tar.gz"
      sha256 "3ab3abe8871fd24680e7c0c79e134c7aa5dbbd68679578cdd0e3ff844d3d8c7f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.6.0/imagine-linux-aarch64.tar.gz"
      sha256 "beddfe5aba5df09718134e36e9c368a92e8dbb2153b6dc5aa3d457e95c0ca8b1"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.6.0/imagine-linux-x86_64.tar.gz"
      sha256 "5ac3bedae625a9e23fc113df2455045da01e8c44c035c10f29f11786046c1ce5"
    end
  end

  def install
    bin.install Dir["imagine-*"].find { |f| File.file?(f) } => "imagine"
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
