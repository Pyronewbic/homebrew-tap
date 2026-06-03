# Homebrew formula for sluice (github.com/Pyronewbic/Sluice).
class Sluice < Formula
  desc "Sandboxed, egress-firewalled container runner for projects and coding agents"
  homepage "https://github.com/Pyronewbic/Sluice"
  # cosign keyless-signed release tarball (verify: see SECURITY.md "Verifying a release").
  url "https://github.com/Pyronewbic/Sluice/releases/download/v0.8.0/sluice-0.8.0.tar.gz"
  sha256 "7b1617bcbeeb778226fdbaf969bcf1f66f9ca053600bca692882b3481b0f40e3"
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
