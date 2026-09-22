class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.4.0/imagine-macos-aarch64.tar.gz"
      sha256 "cdb16fac2e31b2dd16e7784ad61572442286517eb93d260a6fbfbde5ccbfbde7"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.4.0/imagine-macos-x86_64.tar.gz"
      sha256 "2dc86b13cbeab26b2df2a94bf74d42c0567788acff9c190b418f3014e2039bcf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.4.0/imagine-linux-aarch64.tar.gz"
      sha256 "94b369d0ce3449b56d8b365fe7a5e2121be45e411f8fcca272c0d521bb949b6d"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.4.0/imagine-linux-x86_64.tar.gz"
      sha256 "38576546073299b842bef49616e9f89188186f073922d07d46c118abdac543b3"
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
