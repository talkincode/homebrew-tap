class Filmkit < Formula
  desc "Agent-oriented video orchestration compiler"
  homepage "https://github.com/talkincode/filmkit"
  url "https://github.com/talkincode/filmkit/releases/download/v0.8.0/filmkit-0.8.0.tar.gz"
  sha256 "db6241eaa365d41a27d838db1c3d922812a89f7d2c25a516c567c064ee2e3304"
  version "0.8.0"
  license "MIT"

  depends_on "bun"
  depends_on "ffmpeg"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/filmkit.ts" => "filmkit"
    bin.install_symlink libexec/"tools/vflow/bin/vflow-pull.ts" => "vflow-pull"
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
    assert_match "--mode production|assemble", shell_output("#{bin}/vflow-pull help")
    assert_match "everything needed for build is present", shell_output("#{bin}/filmkit doctor")
  end
end
