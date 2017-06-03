module Rakyll
  module Compiler
    class Match
      include Apply
      include SetFilename
      attr_reader :body, :url

      def initialize(source_filename, opts)
        @source_filename = source_filename
        metadata_string, markdown_string = File.read(@source_filename).split("---\n")
        set_metadata_from_yaml(metadata_string)
        set_body_from_markdown(markdown_string, opts)
        set_filename(source_filename, '.html')
      end

      def save
        File.write(@filename, @body)
      end

      private
      def set_metadata_from_yaml(metadata_string)
        YAML.load(metadata_string).each do |key, value|
          instance_variable_set(:"@#{key}", value)
          singleton_class.class_eval { attr_reader key }
        end
      end

      def set_body_from_markdown(markdown_string, opts)
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, opts[:redcarpet_extensions] || {})
        @body = markdown.render(markdown_string)
      end
    end
  end
end