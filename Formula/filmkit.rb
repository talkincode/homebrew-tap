class Filmkit < Formula
  desc "Agent-oriented video orchestration compiler"
  homepage "https://github.com/talkincode/filmkit"
  url "https://github.com/talkincode/filmkit/releases/download/v0.7.3/filmkit-0.7.3.tar.gz"
  sha256 "2e3c1aef3cea6e77e0edfcc7ab240eef61fab442b8ad061a35ded1044daef695"
  version "0.7.3"
  license "MIT"

  depends_on "bun"
  depends_on "ffmpeg"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/filmkit.ts" => "filmkit"
  end

  def caveats
    <<~EOS
      The bundled Agent skill is installed under:
        #{opt_pkgshare}/skills/filmkit

      Link it for your agent:
        mkdir -p ~/.agents/skills
        cp -R #{opt_pkgshare}/skills/filmkit ~/.agents/skills/

      filmkit composes with ffmpeg; check any project with \"filmkit doctor\".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/filmkit --version")
    assert_match "everything needed for build is present", shell_output("#{bin}/filmkit doctor")
  end
end
