module Rivalry
  class FindFiles
    def initialize pathname, do_want = {}, do_not_want = {}
      @pathname = Pathname.new File.expand_path(pathname)
      @do_want = do_want
      @do_not_want = do_not_want
    end
    attr :pathname, :do_want, :do_not_want

    def find
      out "Scanning all files..."

      total_size  = 0
      total_count = 0
      all_files   = Array.new
      file_sizes  = Hash.new { |hash, k| hash[k] = [] }

      pathname.find do |path|
        file = Pathname.new path

        if file.directory? then
          if skip? file then
            progress 'SKIP DIR', file
            Find.prune
          else
            progress 'DIRECTORY', file
            all_files << file
          end
        elsif valid? file then
          if want? file then
            progress 'FILE', file

            size = file.size

            file_sizes[size] << file

            all_files << file
            total_size += size
            total_count += 1
          else
            progress 'SKIP FILE', file
          end
        end
      end

      clear_line
      out "-- Total Size  : #{humanize total_size}"
      out "-- Total Count : #{total_count} files"

      file_sizes
    end

    protected

    def want? path
      extension = File.extname path
      do_want.find{|name, pattern| extension =~ pattern} && true
    end

    def skip? path
      basename = File.basename path
      do_not_want.find{|name, pattern| basename =~ pattern} && true
    end

    def valid? file
      file.exists?
    end
  end
end
