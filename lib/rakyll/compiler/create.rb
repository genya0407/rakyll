module Rakyll
  module Compiler
    class Create
      include Apply
      include SetFilename
      include WatchSourceFile
      attr_reader :url

      def initialize(global_options, source_filename, opts)
        @global_options = global_options
        @opts = opts
        set_filename(source_filename)
      end

      def load_all(pattern, opts = {})
        Dir.glob(pattern).map do |filename|
          Match.new filename, opts
        end
      end

      def save
        File.write(@filename, @body)
      end
    end
  end
end