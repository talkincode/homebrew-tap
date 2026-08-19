class Scorekit < Formula
  desc "Agent-oriented music compiler for game-ready loops and stems"
  homepage "https://github.com/talkincode/scorekit"
  version "0.7.1"
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
      url "https://github.com/talkincode/scorekit/releases/download/v0.7.1/scorekit-aarch64-apple-darwin.tar.gz"
      sha256 "1cf1aea94d5cca109dab24cb8205cbdf4b965eeabb5596583794d15d8da3042a"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.7.1/scorekit-x86_64-apple-darwin.tar.gz"
      sha256 "93e50daf545341e4a95f7af4cf60153187b1c1098c215d306f7b55ebf09547a0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/scorekit/releases/download/v0.7.1/scorekit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3d0df17db410bdb939ef65ea445283b1ee3c6dc31c303ca043b6c407879dad3c"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.7.1/scorekit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "287f77a55efa4bee6b8f54d89ac2fb326cd68f170eef7ee53aea47e3b8204055"
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
