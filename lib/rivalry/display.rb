module Rivalry
  module Display
    def self.included object
      unless $silent then
        object.send :include, Methods
      else
        object.send :include, NoopMethods
      end
    end

    def self.extended object
      unless $silent then
        object.send :extend, Methods
      else
        object.send :extend, NoopMethods
      end
    end

    module Methods

      def usage
        puts "usage: #{$0} path/to/search/for/duplicates"
        exit 1
      end

      def out text = ''
        if $verbose then
          puts text
        else
          puts text[0..(width - 1)]
        end
      end

      def progress type, file, count = nil, total = nil
        if count && total then
          tally = " (#{count}/#{total})"
        elsif count then
          tally = " (#{count})"
        else
          tally = ''
        end

        text = "-- #{type}#{tally}: #{file}"

        if $verbose then
          puts text
        else
          clear_line
          print text[0..(width - 1)]
        end
      end

      def clear_line
        clear_line = "\e[2K"
        start_of_line = "\e[0G"
        print start_of_line, clear_line
      end

      def width
        tiocgwinsz = 0x40087468
        str = [0, 0, 0, 0].pack('SSSS')
        if $stdin.ioctl(tiocgwinsz, str) >= 0 then
          str.unpack('SSSS')[1]
        else
          80
        end
      end

      BYTE_UNITS =[[1073741824, 'GB'], [1048576, 'MB'], [1024, 'KB'], [-1, 'B']]

      def humanize bytes
        unit = BYTE_UNITS.find{|u| bytes > u[0] }
        "#{bytes / unit[0]} #{unit[1]}"
      end

    end

    module NoopMethods
      def noop; end

      Methods.instance_methods(false).each do |method|
        alias_method method, :noop
      end
    end
  end
end
