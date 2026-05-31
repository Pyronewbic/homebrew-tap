# Homebrew formula for sluice (github.com/Pyronewbic/Sluice).
class Sluice < Formula
  desc "Sandboxed, egress-firewalled container runner for projects and coding agents"
  homepage "https://github.com/Pyronewbic/Sluice"
  url "https://github.com/Pyronewbic/Sluice/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "9c7bb0a667b5e0385c9c205daa2da8c93b4fa794898f586110af557588bb2ada"
  license "Apache-2.0"

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
