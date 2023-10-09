class GerbilScheme < Formula
# This .rb file is tangled (AKA generated) from README.org
  desc "Opinionated dialect of Scheme designed for Systems Programming"
  homepage "https://cons.io"
  license any_of: ["LGPL-2.1-or-later", "Apache-2.0"]
  url "https://github.com/mighty-gerbils/gerbil.git", using: :git,
      revision: "3414e3f111a38965a549dce0b11aeee2e2771e3a"
  head "https://github.com/mighty-gerbils/gerbil.git", using: :git
  version "0.18"
  revision 0
  depends_on "openssl@3"
  depends_on "sqlite"
  depends_on "zlib"
  depends_on "gcc"
  depends_on "findutils"

  fails_with :clang do
    cause "gerbil-scheme is built with GCC"
  end
    def install
        system "./configure", "--prefix=#{prefix}" #, "--disable-shared"
              
        system "make"
        ENV.deparallelize
        system "make", "install"
        rm prefix/"bin"
        mkdir prefix/"bin"

        cd prefix/"current/bin" do
           ln "gerbil", prefix/"bin", verbose: true
           cp %w(gxc gxensemble gxi gxpkg gxprof gxtags gxtest), prefix/"bin"
        end
    end
    test do
      assert_equal "0123456789", shell_output("#{bin}/gxi -e \"(for-each write '(0 1 2 3 4 5 6 7 8 9))\"")
    end
end