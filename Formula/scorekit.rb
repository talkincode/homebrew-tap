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
      sha256 "36ddc69c642a83ca3990d9e5e7faaf2a158192f2ca9ff5ad97982ec4ef5ba6d4"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-x86_64-apple-darwin.tar.gz"
      sha256 "f249518e31ebc3ff0dc58a9b3c7e7c6180c9ce29987675b7593f1ee9328f1e7e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f696a04459008ca3efe828d0e1db2361ad7711c07c3ae6bfc8bdfef218ba163f"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.1/scorekit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c355bd13931fad35c8934509cf3f66a79e4022cb4edea9f8739ed066965bc204"
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
