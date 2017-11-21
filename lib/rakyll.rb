require 'erb'
require 'yaml/front-matter'
require 'pathname'
require 'fileutils'
require 'redcarpet'

require "rakyll/version"
require "rakyll/route"
require "rakyll/compiler"
require 'rakyll/compiler/copy'
require "rakyll/compiler/minify"
require 'rakyll/compiler/create'
require 'rakyll/compiler/match'

module Rakyll
  def self.dsl(opts = {}, &block)
    route = Rakyll::Route.new opts
    route.instance_eval &block
    if opts[:watch]
      route.watch
    else
      route.save
    end
  end
end
