class Ears < Formula
  desc "Terminal traffic monitor for one network interface"
  homepage "https://github.com/Sousf/ears"
  url "https://github.com/Sousf/ears/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "6c7355ec6d4f49cdfd0b08861d59e07f8f77d793ac7916b69e7f75bb9469caea"

  depends_on "go" => :build
  uses_from_macos "libpcap"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  def caveats
    <<~EOS
      Capturing needs raw socket rights. Either run ears with sudo,
      or grant them to the binary once (Linux):
        sudo setcap cap_net_raw,cap_net_admin=eip #{opt_bin}/ears
      Replaying a capture file with -r needs neither.
    EOS
  end

  test do
    assert_match "usage: ears", shell_output("#{bin}/ears -h 2>&1")
  end
end
