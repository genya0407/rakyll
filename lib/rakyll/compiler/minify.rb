require 'rmagick'

module Rakyll
  module Compiler
    class Minify
      include SetFilename
      include SetSourceFilename
      include WatchSourceFile

      def initialize(global_options, source_filename, width: nil, height: nil, grayscale: false)
        @global_options = global_options
        set_source_filename(source_filename)
        @width = width
        @height = height
        @grayscale = grayscale
        set_filename(source_filename)
      end

      def save
        Magick::Image.read(@source_filename).first.change_geometry!("#{@width}x#{@height}") do |cols, rows, img|
          img.resize!(cols, rows)
          if @grayscale
            img = img.quantize(256, Magick::GRAYColorspace)
          end
          img.write(@filename)
        end
      end
    end
  end
end