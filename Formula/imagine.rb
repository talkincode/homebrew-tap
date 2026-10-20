class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.8.0/imagine-macos-aarch64.tar.gz"
      sha256 "c40f1f570d277f2e62729c60ed8d0f7510507dec1588f7f5da4e685dccc22108"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.8.0/imagine-macos-x86_64.tar.gz"
      sha256 "940aab7e121d28f1653845be225c5d94584814814fa7af04d1564cc48448b675"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.8.0/imagine-linux-aarch64.tar.gz"
      sha256 "512710da5f40d5e2faa4df54aa78d22599af7e5ade3284ac851498e5e563db7e"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.8.0/imagine-linux-x86_64.tar.gz"
      sha256 "7db8ef7c8da14b4aa63929472b2fe32b36ff2bc33b62a6869e89d172da62e1c1"
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
