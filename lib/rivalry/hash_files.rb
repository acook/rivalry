module Rivalry
  class HashFiles < Base
    def initialize similar_files
      @similar_files = similar_files
    end
    attr :similar_files

    def hash
      out
      out "Determining duplicates..."

      similar_count = 0
      file_hashes = FilesWithData.new

      similar_files.each do |file|
        similar_count += 1

        progress 'HASHING', file, similar_count, total_similar

        hash = Digest::SHA256.file(file).to_s

        file_hashes[hash] << file
      end

      file_hashes
    end

    def total_similar
      similar_files.length
    end
  end
end
