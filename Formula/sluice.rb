# Homebrew formula for sluice (github.com/Pyronewbic/Sluice).
class Sluice < Formula
  desc "Sandboxed, egress-firewalled container runner for projects and coding agents"
  homepage "https://github.com/Pyronewbic/Sluice"
  # cosign keyless-signed release tarball (verify: see SECURITY.md "Verifying a release").
  url "https://github.com/Pyronewbic/Sluice/releases/download/v0.7.0/sluice-0.7.0.tar.gz"
  sha256 "1a3438dfa5c649ca01e2493e32d26f5c4d465adf31680117e96b228f50bb25f4"
  license "Apache-2.0"
  head "https://github.com/Pyronewbic/Sluice.git", branch: "main"

  # Runtime needs docker or podman, which Homebrew shouldn't manage - documented, not a dep.

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/sluice"
    # Shell completion (auto-loaded by brew's completion dirs).
    bash_completion.install libexec/"completion/sluice.bash" => "sluice"
    zsh_completion.install libexec/"completion/_sluice"
  end

  def caveats
    <<~EOS
      sluice needs docker or podman to build and run sandboxes.
      Quickstart:
        cd your-repo && sluice      # scaffold a config, then build + run it sandboxed
        sluice agent claude         # run a coding agent (codex, gemini, ...) sandboxed
      Docs: https://github.com/Pyronewbic/Sluice
    EOS
  end

  test do
    output = shell_output("SLUICE_ENGINE=__nope__ #{bin}/sluice 2>&1", 1)
    assert_match "SLUICE_ENGINE=__nope__ not found", output
  end
end
