module Rakyll
  module Compiler
    class Create
      include Apply
      include SetFilename
      attr_reader :url

      def initialize(source_filename, opts)
        @source_filename = source_filename
        set_filename(source_filename)
      end

      def load_all(pattern)
        Dir.glob(pattern).map do |filename|
          Match.new filename
        end
      end

      def save
        File.write(@filename, @body)
      end
    end
  end
end