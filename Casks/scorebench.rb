cask "scorebench" do
  version "0.3.3"

  on_arm do
    sha256 "6ac0192f258cb2c0e02900c96878b73257c1a26885709c55808c47ca40303728"
    url "https://github.com/talkincode/scorebench/releases/download/v0.3.3/scorebench_0.3.3_aarch64.dmg"
  end

  on_intel do
    sha256 "3310b9027f3bf2cfee4e1d70cb57d5f1b0387500cd777526b6bdc4f4db07aa8c"
    url "https://github.com/talkincode/scorebench/releases/download/v0.3.3/scorebench_0.3.3_x64.dmg"
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
