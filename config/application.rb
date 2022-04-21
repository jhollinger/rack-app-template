require 'pathname'
require 'ostruct'
require 'bundler'

Bundler.require(:default, ENV["RACK_ENV"] || "development")
Dotenv.load("config/env")

module App
  class << self
    attr_accessor :env, :root, :config, :logger
  end

  self.env = ENV["RACK_ENV"] || "development"
  self.root = Pathname.new(File.expand_path("../..", __FILE__))
  self.config = OpenStruct.new
  self.config.env = OpenStruct.new

  config.logger = Logger.new(STDOUT)
  config.log_level = Logger::INFO # DEBUG | INFO | WARN | ERROR | FATAL
  config.log_formatter = nil

  config.env.database_url = ENV['DATABASE_URL']
end
