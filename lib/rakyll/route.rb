module Rakyll
  class Route
    def initialize(opts)
      @opts = opts
      @compilers = []
    end

    def match(pattern, &block)
      Dir.glob(pattern).each do |source_filename|
        compiler = Rakyll::Compiler::Match.new source_filename, @opts
        compiler.instance_eval &block
        @compilers.push compiler
      end
    end

    def copy(pattern)
      Dir.glob(pattern).each do |source_filename|
        compiler = Rakyll::Compiler::Copy.new source_filename, @opts
        @compilers.push compiler
      end
    end

    def create(filename, &block)
      compiler = Rakyll::Compiler::Create.new filename, @opts
      compiler.instance_eval &block
      @compilers.push compiler
    end

    def save
      @compilers.each do |compiler|
        compiler.save
      end
    end
  end
end