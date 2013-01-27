module Rivalry
  class FindFiles
    def initialize pathname, do_want = {}, do_not_want = {}
      @pathname = Pathname.new File.expand_path(pathname)
      @do_want = do_want
      @do_not_want = do_not_want
    end
    attr :pathname, :do_want, :do_not_want, :count, :size

    def find
      self.size  = 0
      self.count = 0

      files_with_sizes  = Hash.new { |hash, k| hash[k] = [] }

      pathname.find do |file|

        if file.directory? then
          if skip? file then
            progress 'SKIP DIR', file
            Find.prune
          else
            progress 'DIRECTORY', file
          end
        elsif valid? file then
          if want? file then
            progress 'FILE', file

            file_size = file.size

            files_with_sizes[file_size] << file

            self.size += file_size
            self.count += 1
          else
            progress 'SKIP FILE', file
          end
        end

      end

      files_with_sizes
    end

    protected

    attr_writer :count, :size

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
