require_relative 'application'

# Add lib/ to load path
$:.unshift App.root.join('lib').to_s

# Set up logger
App.logger = App.config.logger
App.logger.level = App.config.log_level
App.logger.formatter = App.config.log_formatter

# Load files
Zeitwerk::Loader.new.tap do |loader|
  loader.push_dir App.root.join("app")
  loader.collapse App.root.join("app", "*")
  loader.setup

  require App.root.join("config", "environments", App.env)
  Dir.glob(App.root.join("config", "initializers", "*.rb")) do |initializer|
    require initializer
  end

  loader.eager_load if App.config.eager_load
end
