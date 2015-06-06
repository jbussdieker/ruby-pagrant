require 'erb'

module Pagrant
  class Project
    def initialize(path)
      @path = path
    end

    def walk_tree(source, dest)
      Dir.entries(source).each do |entry|
        unless [".", ".."].include?(entry)
          newsource = File.join(source, entry)
          newdest = File.join(dest, entry)

          if Dir.exists?(newsource)
            Dir.mkdir(newdest) unless Dir.exists?(newdest)
            walk_tree(newsource, newdest)
          else
            newfile = newdest[0..-5]

            puts newsource
            puts newfile
            puts

            template = ERB.new(File.read(newsource))

            File.open(newfile, 'w') do |f|
              f.write(template.result(binding))
            end
          end
        end
      end
    end

    def generate
      Dir.mkdir(@path) unless Dir.exists?(@path)
      walk_tree(TEMPLATE_DIR, @path)
    end
  end
end
