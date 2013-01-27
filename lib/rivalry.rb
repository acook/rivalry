require 'pry' rescue LoadError

require 'rivalry/version'
require 'rivalry/display'
require 'rivalry/base'
require 'rivalry/scanner'
require 'rivalry/file_path'
require 'rivalry/files_with_data'
require 'rivalry/find_files'
require 'rivalry/hash_files'

module Rivalry
  extend Display
  module_function

  def run args
    path = args.first || usage

    scanner = Rivalry::Scanner.new path
    files = scanner.scan

    out
    files.each do |file|
      puts file.to_s
    end
  end
end
