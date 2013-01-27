module Rivalry
  class FilesWithData < Hash
    def initialize
      super { |hash, key| hash[key] = Array.new }
    end
  end
end
