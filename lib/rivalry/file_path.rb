module Rivalry
  class FilePath < Pathname
    alias_method :each, :each_child
    alias_method :exists?, :exist?
  end
end
