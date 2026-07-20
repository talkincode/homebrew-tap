class Scorekit < Formula
  desc "Agent-oriented music compiler for game-ready loops and stems"
  homepage "https://github.com/talkincode/scorekit"
  version "0.2.1"
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
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-aarch64-apple-darwin.tar.gz"
      sha256 "b3a196ff9ad3518d45a4ac1f62d6fa9067d62606cc32439d198b6d46889cf8f7"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-x86_64-apple-darwin.tar.gz"
      sha256 "5cff7a84467292b443eaadf981e4c35ea5f460ee1de5a71564293fa0a45eb3ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e3b70a357020c6893bf60e0ad765b8ddf732a3a58e20a5559ed7654131595ff1"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3ae3577ab2fa53ca0aca5e89775c7240848e0c0fe4d9d828a4a14d7f136e586"
    end
  end

  def install
    package_dir = Dir["scorekit-*"].first
    libexec.install "#{package_dir}/scorekit"
    bin.write_env_script libexec/"scorekit",
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
