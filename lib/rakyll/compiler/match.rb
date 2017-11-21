module Rakyll
  module Compiler
    class Match
      include Apply
      include SetFilename
      include SetSourceFilename
      include WatchSourceFile
      include SetExtraDependencies
      attr_reader :body, :url

      def initialize(global_options, dependencies, source_filename, block)
        @global_options = global_options
        set_extra_dependencies(dependencies)
        set_source_filename(source_filename)
        metadatas, markdown_string = YAML::FrontMatter.extract(File.read(@source_filename))
        set_metadatas(metadatas)
        @body = markdown_string
        set_filename(source_filename, '.html')

        @block = block
        instance_eval &block
      end

      def convert_to_html
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, @global_options[:redcarpet_extensions] || {})
        @body = markdown.render(@body)
      end

      def save
        instance_eval &@block
        File.write(@filename, @body)
      end

      private
      def set_metadatas(metadatas)
        metadatas.each do |key, value|
          instance_variable_set(:"@#{key}", value)
          singleton_class.class_eval { attr_reader key }
        end
      end
    end
  end
end