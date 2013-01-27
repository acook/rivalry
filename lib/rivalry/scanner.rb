require 'find'
require 'pathname'
require 'digest'

module Rivalry
  class Scanner
    def initialize pathname
      @pathname = Pathname.new File.expand_path(pathname)
    end
    attr :pathname

    def scan
      files_with_sizes = FindFiles.new(pathname).find

      similar_files = files_with_sizes.map{|size, file_list| file_list if file_list.length > 1 }.flatten.compact
      total_similar = similar_files.length

      out "-- Similar     : #{total_similar} files with the same size"

      files_with_hashes = HashFiles.new(similar_files, wants, ignores).hash

      duplicate_files = file_with_hashes.map{|hash, file_list| file_list if file_list.length > 1 }.flatten.compact

      clear_line
      out "-- Dupes Count : #{duplicate_files.length} files"
      out

      duplicate_files
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
