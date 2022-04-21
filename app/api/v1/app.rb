class V1::App < Grape::API
  version 'v1', using: :path
  default_format :json
  format :json

  rescue_from Grape::Exceptions::ValidationErrors, ->(e) { error! e.full_messages, 400 }
  rescue_from ActiveRecord::RecordNotFound, ->(e) { error! "Could not find #{e.model}", 400 }
  rescue_from :all, ->(e) {
    ::App.logger.error e
    error! "Server error", 500
  }

  error_formatter :json, ->(message, backtrace, options, env, _) {
    {errors: Array(message)}.to_json
  }

  get :foo do
    {foo: "bar"}
  end

  # mount V1::Widgets
end
