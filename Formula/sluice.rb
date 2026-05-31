# Homebrew formula for sluice (github.com/Pyronewbic/Sluice).
class Sluice < Formula
  desc "Sandboxed, egress-firewalled container runner for projects and coding agents"
  homepage "https://github.com/Pyronewbic/Sluice"
  url "https://github.com/Pyronewbic/Sluice/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "3c96aa0202598583fd34c262744e9a904c4f61660e4c79707ebdce37c7f49908"
  license "Apache-2.0"
  head "https://github.com/Pyronewbic/Sluice.git", branch: "main"

  # Runtime needs docker or podman, which Homebrew shouldn't manage - documented, not a dep.

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/sluice"
  end

  test do
    output = shell_output("SLUICE_ENGINE=__nope__ #{bin}/sluice 2>&1", 1)
    assert_match "SLUICE_ENGINE=__nope__ not found", output
  end
end
