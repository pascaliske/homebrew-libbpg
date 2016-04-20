class Libbpg < Formula
  desc "Image format meant to improve on JPEG quality and file size"
  homepage "http://bellard.org/bpg/"
  url "http://bellard.org/bpg/libbpg-0.9.5.tar.gz"
  sha256 "30de1d0099920e24b7c9aae4d4e6b62f446823f0a1d52eb195dfc25c662ee203"

  option "with-jctvc", "Enable built-in JCTVC encoder - Mono threaded, slower but produce smaller file"
  option "without-x265", "Disable built-in x265 encoder - Multi threaded, faster but produce bigger file"

  depends_on "cmake" => :build
  depends_on "yasm" => :build if build.with? "x265"
  depends_on "libpng"
  depends_on "jpeg"

  def install
    bin.mkpath

    args = []
    args << "USE_JCTVC=y" if build.with? "jctvc"
    args << "USE_X265=" if build.without? "x265"

    system "make", "install", "prefix=#{prefix}", "CONFIG_APPLE=y", *args
  end

  test do
    system "#{bin}/bpgenc", test_fixtures("test.png")
  end
end
