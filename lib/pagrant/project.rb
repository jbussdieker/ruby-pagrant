require 'erb'

module Pagrant
  class Project
    def initialize(path)
      @path = path
    end

    def safe_mkdir(path)
      unless Dir.exists?(path)
        puts "Creating #{path}"
        Dir.mkdir(path)
      end
    end

    def walk_tree(source, dest)
      Dir.entries(source).each do |entry|
        unless [".", ".."].include?(entry)
          newsource = File.join(source, entry)
          newdest = File.join(dest, entry)

          if Dir.exists?(newsource)
            safe_mkdir(newdest)
            walk_tree(newsource, newdest)
          else
            newfile = newdest[0..-5]

            puts "Writing #{newfile}"

            template = ERB.new(File.read(newsource))

            File.open(newfile, 'w') do |f|
              f.write(template.result(binding))
            end
          end
        end
      end
    end

    def generate
      safe_mkdir(@path)
      walk_tree(TEMPLATE_DIR, @path)
    end
  end
end
