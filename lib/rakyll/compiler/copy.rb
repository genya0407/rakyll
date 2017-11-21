module Rakyll
  module Compiler
    class Copy
      include SetFilename
      include SetSourceFilename
      include WatchSourceFile

      def initialize(global_options, source_filename, opts)
        @global_options = global_options
        @opts = opts
        set_source_filename(source_filename)
        set_filename(source_filename)
      end

      def save
        FileUtils.copy(@source_filename, @filename)
      end
    end
  end
end