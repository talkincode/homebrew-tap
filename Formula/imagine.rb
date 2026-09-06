class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.1.2/imagine-macos-aarch64.tar.gz"
      sha256 "08000f4272a2487a6778ed12693e1a4a546a62ac458ac4b86ac595983d1ab0f9"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.1.2/imagine-macos-x86_64.tar.gz"
      sha256 "668ff3556942ae03f18ff4b7f69fbfa2436fc4959d29888a95ca44685c36ba63"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.1.2/imagine-linux-aarch64.tar.gz"
      sha256 "5d3e0b6260d8cbf2439b4768cd7a54b0926695debe161d3c9fb40463fe4a4070"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.1.2/imagine-linux-x86_64.tar.gz"
      sha256 "513821a401fc4960ca5da2e8ee15d8097a43d96cc1ae9f11440bdf9e25cf20d5"
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
