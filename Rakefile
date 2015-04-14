require 'tmpdir'
require 'open-uri'
require 'archive/tar/minitar'
require 'zlib'
require 'fileutils'
require 'bundler'
Bundler::GemHelper.install_tasks

desc 'Add ruby headers under lib for a given VERSION and PATCHLEVEL'
task :add_source do
  version = ENV['VERSION'] or abort "Need a $VERSION"
  ruby_dir = "ruby-#{version}"
  minor_version = version.split('.')[0..1].join('.')
  uri_path = "http://ftp.ruby-lang.org/pub/ruby/#{minor_version}/#{ruby_dir}.tar.gz"
  dest_dir = File.dirname(__FILE__) + "/lib/debase/ruby_core_source/#{ruby_dir}"

  patchlevel = ENV['PATCHLEVEL']
  if patchlevel
    dest_dir = dest_dir + "-p" + patchlevel
  elsif !version.include?('-p')
    abort "Need a $PATCHLEVEL"
  end


  puts "Downloading #{uri_path}..."
  temp = open(uri_path)
  puts "Unpacking #{uri_path}..."
  tgz = Zlib::GzipReader.new(File.open(temp, "rb"))

  FileUtils.mkdir_p(dest_dir)
  Dir.mktmpdir do |dir|
    inc_dir = dir + "/" + ruby_dir + "/*.inc"
    hdr_dir = dir + "/" + ruby_dir + "/*.h"
    more_hdr_dir = dir + "/" + ruby_dir + "/ccan/**/*.h"
    Archive::Tar::Minitar.unpack(tgz, dir)
    Dir.glob([ inc_dir, hdr_dir, more_hdr_dir ]).each do |file|
      target = file.sub(dir + '/' + ruby_dir, dest_dir)
      FileUtils.mkdir_p(File.dirname(target))
      FileUtils.cp(file, target, verbose: false)
    end
  end
end

