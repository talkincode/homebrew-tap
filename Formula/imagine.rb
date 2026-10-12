class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.6.1/imagine-macos-aarch64.tar.gz"
      sha256 "6d0cd8037c50113c02af2b93c948be9087cf643a66747d7a2dd0cd30a4d86260"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.6.1/imagine-macos-x86_64.tar.gz"
      sha256 "e3a4e132730d338bc6b3d4958b6b3a5fe68227483c1456dbfd237e965af66311"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.6.1/imagine-linux-aarch64.tar.gz"
      sha256 "80e97b4e3dd9e0bc7aa93268bd586a7db6e0a7041348778b6d781e4a82d138b8"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.6.1/imagine-linux-x86_64.tar.gz"
      sha256 "17fc3d96d59d3ee5db2ab94c5a9086cb6c36b1013eeb638af842b5a688513d6b"
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
