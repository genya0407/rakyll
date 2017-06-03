module Rakyll
  module Compiler
    class Copy
      include SetFilename

      def initialize(source_filename, opts)
        @source_filename = source_filename
        set_filename(source_filename)
      end

      def save
        FileUtils.copy(@source_filename, @filename)
      end
    end
  end
end