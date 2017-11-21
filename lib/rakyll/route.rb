require 'listen'
require 'webrick'

module Rakyll
  class Route
    def initialize(opts)
      @global_options = opts
      @compilers = []
    end

    def match(pattern, &block)
      Dir.glob(pattern).each do |source_filename|
        compiler = Rakyll::Compiler::Match.new @global_options, source_filename, @opts
        compiler.instance_eval &block
        @compilers.push compiler
      end
    end

    def copy(pattern)
      Dir.glob(pattern).each do |source_filename|
        compiler = Rakyll::Compiler::Copy.new @global_options, source_filename, @opts
        @compilers.push compiler
      end
    end

    def minify(pattern, width: nil, height: nil, grayscale: false)
      Dir.glob(pattern).each do |source_filename|
        compiler = Rakyll::Compiler::Minify.new @global_options, source_filename, width: width, height: height, grayscale: grayscale
        @compilers.push compiler
      end
    end

    def create(filename, &block)
      compiler = Rakyll::Compiler::Create.new @global_options, filename, @opts
      compiler.instance_eval &block
      @compilers.push compiler
    end

    def save
      @compilers.each(&:save)
    end

    def save_unless_exist
      @compilers.each(&:save_unless_exist)
    end

    def watch
      save_unless_exist
      watchers = @compilers.select { |comp| comp&.should_watch? }.map(&:watchers).flatten
      watchers.each(&:start)
      WEBrick::HTTPServer.new(:DocumentRoot => "./_site", :Port => 8000).start
    end
  end
end