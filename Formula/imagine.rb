class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-macos-aarch64.tar.gz"
      sha256 "0ebd957fc75cf17047a5082b659c6a8d3caabe2ddbd099ca865fe51b25ea7f61"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-macos-x86_64.tar.gz"
      sha256 "eebc1f28e01c069fd90f290146d072dfb07fb56ee38d9d964132cc9d232678f8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-linux-aarch64.tar.gz"
      sha256 "7cfe4047eb6ad4b3e62aa3cec5709952628ab3dc1212611722ca333d0b1e15e4"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.1.3/imagine-linux-x86_64.tar.gz"
      sha256 "f7a4d494626b63bd1fc7db6bcdc21a66e5c88abb5a2b0d2f069605a4d56e799f"
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
