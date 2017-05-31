require 'erb'
require 'yaml'
require 'pathname'
require 'fileutils'
require 'redcarpet'

require "rakyll/version"
require "rakyll/route"
require "rakyll/compiler"
require 'rakyll/compiler/copy'
require 'rakyll/compiler/create'
require 'rakyll/compiler/match'

module Rakyll
  def self.dsl(&block)
    route = Rakyll::Route.new
    route.instance_eval &block
    route.save
  end
end
