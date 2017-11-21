module Rakyll
  module Compiler
    module Apply
      def apply(template_name)
        template_path = 'templates/' + template_name
        @template_paths ||= []
        @template_paths.push(template_path)
        template_string = File.read(template_path)
        @body = ERB.new(template_string).result(binding)
      end

      def paths_to_watch
        if defined?(super)
          super + @template_paths
        else
          @template_paths
        end
      end
    end

    module SetFilename
      def set_filename(source_filename, ext = nil)
        pathname = Pathname.new(source_filename)
        pathname = pathname.sub_ext(ext) unless ext.nil?
        @url = '/' + pathname.to_s
        @filename = ['_site', @global_options[:root_path], pathname.to_s].compact.join('/')
        FileUtils.mkdir_p(File.dirname(@filename))
      end

      def save_unless_exist
        unless File.exist?(@filename)
          save
        end
      end
    end

    module SetSourceFilename
      def set_source_filename(source_filename)
        @source_filename = source_filename
      end

      def paths_to_watch
        if defined?(super)
          super + [@source_filename]
        else
          [@source_filename]
        end
      end
    end

    module SetExtraDependencies
      def set_extra_dependencies(dependencies)
        @dependencies = dependencies
      end

      def paths_to_watch
        if defined?(super)
          super + @dependencies
        else
          @dependencies
        end
      end
    end

    module WatchSourceFile
      require 'listen'

      def should_watch?
        true
      end

      def watchers
        paths_to_watch.map do |path|
          filename = File.basename path
          dirname = File.dirname path
          Listen.to(dirname, only: /#{filename}$/, ignore: /_site/) do |modified, added, removed|
            if !modified.nil?
              puts "Updating: #{path} #{self}"
              save
            elsif !removed.nil?
              puts "Stop: #{path}"
              stop
            else
              puts 'something going wroung!'
            end
          end
        end
      end
    end
  end
end