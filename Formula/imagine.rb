class Imagine < Formula
  desc "Universal image-generation CLI for AI agents"
  homepage "https://github.com/talkincode/imagine"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-macos-aarch64.tar.gz"
      sha256 "f849144c99a2999955dd9e2aebe8b16f31599aeb81c070fa933bab067ca58da6"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-macos-x86_64.tar.gz"
      sha256 "2872d510922c54ab89f32a1666363b93513c02e8797f6b728f88c4c43e8dc51e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-linux-aarch64.tar.gz"
      sha256 "2726b4abf99f24a34b454f61917f233500b6be29ec4e427b342161de53afc5cc"
    else
      url "https://github.com/talkincode/imagine/releases/download/v0.5.0/imagine-linux-x86_64.tar.gz"
      sha256 "388bfa81ea8d0ef5ef27da94c9cb1765ca53ea1f0a8829809c09c1760b8c2880"
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
