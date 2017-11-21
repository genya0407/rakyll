module Rakyll
  module Compiler
    class Create
      include Apply
      include SetFilename
      include WatchSourceFile
      include SetExtraDependencies
      attr_reader :url

      def initialize(global_options, dependencies, source_filename, block)
        @global_options = global_options
        set_extra_dependencies(dependencies)
        set_filename(source_filename)

        @block = block
        instance_eval &block
      end

      def load_all(pattern, opts = {})
        Dir.glob(pattern).map do |filename|
          Match.new @global_options, filename
        end
      end

      def save
        instance_eval &@block
        File.write(@filename, @body)
      end
    end
  end
end