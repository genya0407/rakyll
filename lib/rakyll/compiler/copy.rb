module Rakyll
  module Compiler
    class Copy
      include SetFilename
      include SetSourceFilename
      include WatchSourceFile

      def initialize(global_options, source_filename)
        @global_options = global_options
        set_source_filename(source_filename)
        set_filename(source_filename)
      end

      def save
        FileUtils.copy(@source_filename, @filename)
      end
    end
  end
end