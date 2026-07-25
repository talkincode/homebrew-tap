class ScorekitSfizz < Formula
  desc "Offline SFZ renderer backend for scorekit (--renderer sfizz)"
  homepage "https://github.com/talkincode/scorekit"
  url "https://github.com/sfztools/sfizz/archive/refs/tags/1.2.3.tar.gz"
  sha256 "fc1d7864516546e237e7c6115dc76d187924af32ec8eafb97b03a7efec9aa49d"
  license "BSD-2-Clause"

  depends_on "cmake" => :build
  depends_on "scorekit"

  def install
    # Keep sfizz's 32-bit ARM flags from matching arm64 (Apple Silicon).
    inreplace "cmake/SfizzConfig.cmake",
              'PROJECT_SYSTEM_PROCESSOR MATCHES "(arm.*)"',
              'PROJECT_SYSTEM_PROCESSOR MATCHES "(arm(v[0-9].*)?)$"'
    # Newer clang rejects these non-dependent  disambiguators.
    inreplace "external/atomic_queue/include/atomic_queue/atomic_queue.h" do |s|
      s.gsub!("Base::template do_pop_any", "Base::do_pop_any")
      s.gsub!("Base::template do_push_any", "Base::do_push_any")
    end

    args = std_cmake_args + %W[
      -DSFIZZ_JACK=OFF
      -DSFIZZ_RENDER=ON
      -DSFIZZ_SHARED=OFF
      -DSFIZZ_TESTS=OFF
      -DSFIZZ_DEMOS=OFF
      -DSFIZZ_BENCHMARKS=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build", "--target", "sfizz_render"

    renderer = Dir["build/**/sfizz_render"].find { |path| File.executable?(path) }
    odie "sfizz_render build artifact not found" if renderer.nil?
    bin.install renderer => "sfizz_render"
  end

  test do
    assert_match "sfizz", shell_output("#{bin}/sfizz_render --help")
  end
end
