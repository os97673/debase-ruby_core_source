require 'rbconfig'

module Ruby_core_source
  REVISION_MAP = {
    24186 => 'ruby-1.9.2-preview1',
    27362 => 'ruby-1.9.2-preview3',
    28524 => 'ruby-1.9.2-rc1',
    28618 => 'ruby-1.9.2-rc2',
    32789 => 'ruby-1.9.3-preview1',
    33323 => 'ruby-1.9.3-rc1'
  }

def create_makefile_with_core(hdrs, name)

  #
  # First, see if the gem already has the needed headers
  #
  if hdrs.call
    create_makefile(name)
    return true
  end

  ruby_dir = if RUBY_PATCHLEVEL < 0
    REVISION_MAP[RUBY_REVISION] or
      no_source_abort("ruby-#{RUBY_VERSION} (revision #{RUBY_REVISION})")
  else
    "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
  end

  #
  # Check if core headers were already downloaded; if so, use them
  #
  dest_dir = RbConfig::CONFIG["rubyhdrdir"] + "/" + ruby_dir
  with_cppflags("-I" + dest_dir) {
    if hdrs.call
      create_makefile(name)
      return true
    end
  }

  dest_dir = File.dirname(__FILE__) + "/debugger/ruby_core_source/#{ruby_dir}"
  no_source_abort(ruby_dir) unless File.directory?(dest_dir)

  with_cppflags("-I" + dest_dir) {
    if hdrs.call
      create_makefile(name)
      return true
    end
  }
  return false
end
module_function :create_makefile_with_core

def self.no_source_abort(ruby_version)
  abort "No source for #{ruby_version} provided with debugger-ruby_core_source gem."
end

end
