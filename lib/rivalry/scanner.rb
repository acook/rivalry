require 'find'
require 'pathname'
require 'digest'

module Rivalry
  class Scanner < Base
    def initialize pathname
      @pathname = FilePath.new File.expand_path(pathname)
    end
    attr :pathname

    def scan

      out "Scanning all files..."

      finder = FindFiles.new pathname, wants, ignores
      files_with_sizes = finder.find

      similar_files = dedup files_with_sizes

      clear_line
      out "-- Total Size  : #{humanize finder.size}"
      out "-- Total Count : #{finder.count} files"
      out "-- Similar     : #{similar_files.length} files with the same size"

      hasher = HashFiles.new similar_files
      files_with_hashes = hasher.hash

      duplicate_files = dedup files_with_hashes

      clear_line
      out "-- Dupes Count : #{duplicate_files.length} files"

      duplicate_files
    end

    def dedup files_with_data
      files_with_data.map do |_, file_list|
        file_list if file_list && file_list.length > 1
      end.flatten.compact
    end

    def ignores
      {
        dir: /^\.$/,
        scm: /^\.(git|hg|svn|gitkeep)$/
      }
    end

    def wants
      {
        audio:  /^\.(mp3|ogg|flac|wav|aiff|mid)$/i,
        images: /^\.(png|jpg|gif|bmp|tga|jpeg|tif|tiff)/i
      }
    end
  end
end
