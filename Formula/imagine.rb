class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.7.0/imagine-macos-aarch64.tar.gz"
      sha256 "971eb50de64a0f8f101b09201857473f6f84fc85ef55307f60d2b6dc88b9585c"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.7.0/imagine-macos-x86_64.tar.gz"
      sha256 "0b14a8b289703d1291389f31f8aba9dc41cf10804150f595e45c77f20ebfe40e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.7.0/imagine-linux-aarch64.tar.gz"
      sha256 "76f86d9f9e1de9e85d9700aa81b1007cf17699f4f05e6f5173dea654a0d19678"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.7.0/imagine-linux-x86_64.tar.gz"
      sha256 "1191f063daea2830d92f46d1ccc0e7fdc5b1b1d530d9349226aadbbd5aed77c2"
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
