require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Intl < AbstractPhp53Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.3.18.tar.bz2/from/this/mirror'
  sha1 '561b7ed1ad147346d97f4cac78159e5918a7b5b9'
  version '5.3.18'

  depends_on 'autoconf' => :build
  depends_on 'icu4c'
  depends_on 'php53' unless build.include?('without-homebrew-php')

  def install
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-intl"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
