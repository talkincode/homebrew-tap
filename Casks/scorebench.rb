cask "scorebench" do
  version "0.3.0"

  on_arm do
    sha256 "862a0caea08cb97fa85f6743cb0551eb375976816c25550af2423e3afd00e92b"
    url "https://github.com/talkincode/scorebench/releases/download/v0.3.0/scorebench_0.3.0_aarch64.dmg"
  end

  on_intel do
    sha256 "a0b7b49f20d90c09d3b5018f64405eb9e63e721a6188b4752b98c8e7c5bed58f"
    url "https://github.com/talkincode/scorebench/releases/download/v0.3.0/scorebench_0.3.0_x64.dmg"
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
