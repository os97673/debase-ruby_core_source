require 'tempfile'
require 'tmpdir'
require 'uri'
require 'contrib/uri_ext'
require 'archive/tar/minitar'
require 'zlib'
require 'fileutils'

desc 'Add ruby headers under lib for a given VERSION'
task :add_source do
  version = ENV['VERSION'] or abort "Need a $VERSION"
  ruby_dir = "ruby-#{version}"
  uri_path = "http://ftp.ruby-lang.org/pub/ruby/1.9/#{ruby_dir}.tar.gz"
  dest_dir = File.dirname(__FILE__) + "/lib/debugger/ruby_core_source/#{ruby_dir}"

  Tempfile.open("ruby-src") do |temp|
    temp.binmode
    uri = URI.parse(uri_path)
    uri.download(temp)

    tgz = Zlib::GzipReader.new(File.open(temp, "rb"))

    FileUtils.mkdir_p(dest_dir)
    Dir.mktmpdir do |dir|
      inc_dir = dir + "/" + ruby_dir + "/*.inc"
      hdr_dir = dir + "/" + ruby_dir + "/*.h"
      Archive::Tar::Minitar.unpack(tgz, dir)
      FileUtils.cp(Dir.glob([ inc_dir, hdr_dir ]), dest_dir)
    end
  end

end
