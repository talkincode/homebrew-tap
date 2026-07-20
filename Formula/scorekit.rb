class Scorekit < Formula
  desc "Agent-oriented music compiler for game-ready loops and stems"
  homepage "https://github.com/talkincode/scorekit"
  version "0.2.2"
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
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.2/scorekit-aarch64-apple-darwin.tar.gz"
      sha256 "e479826471a53b5c80b5d7f95808ec033e426c14f138380d921d502656121bc7"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.2/scorekit-x86_64-apple-darwin.tar.gz"
      sha256 "040524a0a5743efd31c9dca487bdcf3253c599869579125bee186a54b410dee7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.2/scorekit-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c415c4449ccd5994f065cfa76813496fc56119d538da0c6f33ab2d2d3dd4f258"
    else
      url "https://github.com/talkincode/scorekit/releases/download/v0.2.2/scorekit-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc05329a00181665aabf6e3ff4d74a5a6fd36340480dcce4958169d246dd5753"
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
