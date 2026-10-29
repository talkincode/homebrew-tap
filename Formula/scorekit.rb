class Scorekit < Formula
  desc "Agent-oriented music compiler for game-ready loops and stems"
  homepage "https://github.com/talkincode/scorekit"
  version "0.9.0"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "fluid-synth"

  resource "musescore_general_soundfont" do
    url "https://ftp.osuosl.org/pub/musescore/soundfont/MuseScore_General/MuseScore_General.sf2"
    sha256 "ee51d2c4b1525e70f19a45909c4fd7a2e26d91d115fa89dbf5a6bc413d8b9bf3"
  end

  resource "musescore_general_license" do
    url "https://ftp.osuosl.org/pub/musescore/soundfont/MuseScore_General/MuseScore_General_License.md"
    sha256 "5ad8d737e13c7f01f5b9674872a82a92b4ba253603e8ed14b9db12293550b4b9"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/scorekit/releases/download/v0.9.0/scorekit-aarch64-apple-darwin.tar.gz"
      sha256 "c4044d57fb0e95f873521ceed42c8cef1699d2bd613cae69265faf11323816ec"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.9.0/scorekit-x86_64-apple-darwin.tar.gz"
      sha256 "b81b0118d3f94efc83afcf6137bff3ccb68e59e66a386d864369e09ca400fcd1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/scorekit/releases/download/v0.9.0/scorekit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "37ed0d7f210c0d84467bb0f89795d50a6630a6e9225156f6519c9c8f026081c8"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.9.0/scorekit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "402fd5bb365cf944b5f76b10bb534a4852528184192d69a93b946f157c52ddb0"
    end
  end

  def install
    # Homebrew strips a sole top-level directory during staging, so the
    # binary may be either at the stage root or under scorekit-<target>/.
    package_dir = Dir["scorekit-*"].first || "."
    libexec.install "#{package_dir}/scorekit"
    (bin/"scorekit").write_env_script libexec/"scorekit",
                                      SCOREKIT_SOUND_LIBRARY_DIR: (pkgshare/"sounds").to_s

    pkgshare.install "#{package_dir}/skills" if File.directory?("#{package_dir}/skills")
    resource("musescore_general_soundfont").stage do
      (pkgshare/"sounds/sf2").install "MuseScore_General.sf2"
    end
    resource("musescore_general_license").stage do
      (pkgshare/"sounds/sf2").install "MuseScore_General_License.md"
    end
  end

  def caveats
    <<~EOS
      The bundled Agent skill is installed under:
        #{pkgshare}/skills/scorekit

      The scorekit wrapper sets SCOREKIT_SOUND_LIBRARY_DIR to:
        #{pkgshare}/sounds

      Set SCOREKIT_SOUND_LIBRARY_DIR yourself or pass --soundfont to use a
      project-managed sound library instead.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scorekit --version")
    assert_match "scorekit_version", shell_output("#{bin}/scorekit --json doctor")
  end
end
