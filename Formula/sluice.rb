# Homebrew formula for sluice (github.com/Pyronewbic/Sluice).
class Sluice < Formula
  desc "Sandboxed, egress-firewalled container runner for projects and coding agents"
  homepage "https://github.com/Pyronewbic/Sluice"
  url "https://github.com/Pyronewbic/Sluice/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "acb9e0e7b153f4499312e6285853d461df4b6cecfa9a84d54832276ff3acb41d"
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
