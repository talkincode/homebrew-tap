class Filmkit < Formula
  desc "Agent-oriented video orchestration compiler"
  homepage "https://github.com/talkincode/filmkit"
  url "https://github.com/talkincode/filmkit/releases/download/v0.4.0/filmkit-0.4.0.tar.gz"
  sha256 "6efdf6f3c8e16070c3c11895d6fd5cb61689a42d335e94652035b89eb0aec34b"
  version "0.4.0"
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
