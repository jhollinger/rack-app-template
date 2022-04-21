require_relative 'config/environment'

use Rack::CommonLogger, App.logger

map "/" do
  use OTR::ActiveRecord::ConnectionManagement
  use OTR::ActiveRecord::QueryCache

  run Rack::Cascade.new [
    V1::App,
  ]
end
