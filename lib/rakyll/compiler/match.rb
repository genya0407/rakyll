module Rakyll
  module Compiler
    class Match
      include Apply
      include SetFilename
      attr_reader :body, :url

      def initialize(source_filename, opts)
        @source_filename = source_filename
        metadatas, markdown_string = YAML::FrontMatter.extract(File.read(@source_filename))
        set_metadatas(metadatas)
        set_body_from_markdown(markdown_string, opts)
        set_filename(source_filename, '.html')
      end

      def save
        File.write(@filename, @body)
      end

      private
      def set_metadatas(metadatas)
        metadatas.each do |key, value|
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