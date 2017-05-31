module Rakyll
  module Compiler
    module Apply
      def apply(template_name)
        template_string = File.read('templates/' + template_name)
        @body = ERB.new(template_string).result(binding)
      end
    end

    module SetFilename
      def set_filename(source_filename, ext = nil)
        pathname = Pathname.new(source_filename)
        pathname = pathname.sub_ext(ext) unless ext.nil?
        @url = '/' + pathname.to_s
        @filename = '_site/' + pathname.to_s
        FileUtils.mkdir_p(File.dirname(@filename))
      end
    end
  end
end