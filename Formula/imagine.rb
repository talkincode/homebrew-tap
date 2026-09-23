class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-macos-aarch64.tar.gz"
      sha256 "329ba00d5122efa142b3575e53bc75962d70a8807e46a6c999ad08ee2b9503a3"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-macos-x86_64.tar.gz"
      sha256 "4f1b55ef029422fecbd765d617f4b2aef464362a6e23a95425629bcdd9e496dc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-linux-aarch64.tar.gz"
      sha256 "eb22376ae3ba1a46ff8146cf1fd1362e23f7adde189e9a6b609e1e8d5b5c64b3"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-linux-x86_64.tar.gz"
      sha256 "0c56cb0ca0995774158c351907f7a207b9c4d28c517bd4fbf1eefce1cd70bfb2"
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
