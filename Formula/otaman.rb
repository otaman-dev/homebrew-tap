class Otaman < Formula
  desc "Fast two-panel terminal file manager in the spirit of Total Commander"
  homepage "https://github.com/otaman-dev/otaman"
  url "https://github.com/otaman-dev/otaman/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "434179c47d7c8e6f722b0503746e495230a935d1f4a66a80250a0cb830144d5e"
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
