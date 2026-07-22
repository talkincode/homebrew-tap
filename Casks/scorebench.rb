cask "scorebench" do
  version "0.3.2"

  on_arm do
    sha256 "554d734126265373ff07f50e8ef795c6116bea82ce2d70a66c5c99ceed0f8b32"
    url "https://github.com/talkincode/scorebench/releases/download/v0.3.2/scorebench_0.3.2_aarch64.dmg"
  end

  on_intel do
    sha256 "0938faf8bc816f5f353026cbbd320fa03c75668a14586f4c15c5cdbb19c413ed"
    url "https://github.com/talkincode/scorebench/releases/download/v0.3.2/scorebench_0.3.2_x64.dmg"
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
