class Filmkit < Formula
  desc "Agent-oriented video orchestration compiler"
  homepage "https://github.com/talkincode/filmkit"
  url "https://github.com/talkincode/filmkit/releases/download/v0.3.0/filmkit-0.3.0.tar.gz"
  sha256 "8d221296997327f742a544aa3aca58dd4576c483a98738f48e679e5a357b857e"
  version "0.3.0"
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
