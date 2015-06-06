require "pagrant/version"
require "pagrant/project"

module Pagrant
  TEMPLATE_DIR = File.expand_path("../../templates", __FILE__)

  def self.generate(path)
    Project.new(path).generate
  end
end
