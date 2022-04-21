if App.config.env.database_url
  OTR::ActiveRecord.configure_from_url! App.config.env.database_url
else
  OTR::ActiveRecord.configure_from_file! 'config/database.yml'
end
OTR::ActiveRecord.establish_connection!
