module Pagrant
  class Project
    def initialize(path)
      @path = path
    end

    def walk_tree(path)
      Dir.entries(path).each do |entry|
        unless [".", ".."].include?(entry)
          newpath = File.join(path, entry)

          if Dir.exists?(newpath)
            walk_tree(newpath)
          else
            puts entry
          end
        end
      end
    end

    def generate
      walk_tree(TEMPLATE_DIR)
    end
  end
end
