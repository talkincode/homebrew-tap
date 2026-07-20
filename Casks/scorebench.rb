cask "scorebench" do
  version "0.2.1"

  on_arm do
    sha256 "5e2882facb334e2972338b9d2632400973b2d2e8e6f34d724fe0c553e899d42b"
    url "https://github.com/talkincode/scorebench/releases/download/v0.2.1/scorebench_0.2.1_aarch64.dmg"
  end

  on_intel do
    sha256 "1150543a65016f52a888374679b42fa0ea2356fd0f2febd85eb87cb01067820d"
    url "https://github.com/talkincode/scorebench/releases/download/v0.2.1/scorebench_0.2.1_x64.dmg"
  end

  name "scorebench"
  desc "Agent-native workbench for ScoreKit"
  homepage "https://github.com/talkincode/scorebench"

  depends_on formula: "talkincode/tap/scorekit"

  app "scorebench.app"

  caveats <<~EOS
    scorebench uses the scorekit CLI at runtime. This cask installs the
    Homebrew scorekit formula as a dependency.

    If scorebench cannot locate scorekit, set SCOREBENCH_SCOREKIT to:
      #{HOMEBREW_PREFIX}/bin/scorekit
  EOS
end
