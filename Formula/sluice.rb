# Homebrew formula for sluice (github.com/Pyronewbic/Sluice).
class Sluice < Formula
  desc "Sandboxed, egress-firewalled container runner for projects and coding agents"
  homepage "https://github.com/Pyronewbic/Sluice"
  url "https://github.com/Pyronewbic/Sluice/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "a5f8a9696b483e12a50346d60115f57de3c47fbe953360f8fb36989e137b9b5c"
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

  test do
    output = shell_output("SLUICE_ENGINE=__nope__ #{bin}/sluice 2>&1", 1)
    assert_match "SLUICE_ENGINE=__nope__ not found", output
  end
end
