class Otaman < Formula
  desc "Fast two-panel terminal file manager in the spirit of Total Commander"
  homepage "https://github.com/otaman-dev/otaman"
  url "https://github.com/otaman-dev/otaman/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "1b248ae36662c298dadfe5e13c984ed0646bdd4fe0b03242b26a167e19ddda87"
  license "AGPL-3.0-or-later"
  head "https://github.com/otaman-dev/otaman.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/otaman")
  end

  def caveats
    <<~EOS
      To have your shell stay in Otaman's last directory, add to ~/.zshrc:
        eval "$(otaman --shell-init zsh)"
      (bash: --shell-init bash; fish: otaman --shell-init fish | source)

      The user guide: https://github.com/otaman-dev/otaman/blob/main/docs/user-guide.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/otaman --version")
    assert_match "app.quit", shell_output("#{bin}/otaman --keys")
    assert_match "otaman()", shell_output("#{bin}/otaman --shell-init zsh")
  end
end
