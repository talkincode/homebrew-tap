class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.3.2/imagine-macos-aarch64.tar.gz"
      sha256 "7ac4f7220fc3f46a00501743d9c026940a82be2fa2c87d045408cca7d8852cde"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.3.2/imagine-macos-x86_64.tar.gz"
      sha256 "fee7e670ba07b55e3fbb6fb6d2f9c092660fb8d05336a7bd128d4e7dba3d5034"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.3.2/imagine-linux-aarch64.tar.gz"
      sha256 "d28a65b65c44c68c29c88c467551b90002a90fe1c85ea3111eb67f6a7b93ea69"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.3.2/imagine-linux-x86_64.tar.gz"
      sha256 "45c77922914d65dfece78d0c59a0c6b2b33a8060e83009e136c46f107b5f1e9b"
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
