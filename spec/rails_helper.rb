ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'

require 'rspec/rails'
require 'rspec/mocks'
require 'database_cleaner'
require 'factory_girl'
require 'faker'
require 'shoulda/matchers'
require 'json_spec'

require File.join(Ganttin::Environment.dummy_path, 'config/environment')

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Dir[File.join(Ganttin::Environment.root, 'spec/support/**/*.rb')].each { |f| require f }
Dir[File.join(Ganttin::Environment.root, 'spec/factories/**/*.rb')].each { |f| require f }

Rails.logger.level = 4

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include JsonSpec::Helpers

  config.before(:suite) do
    ::DatabaseCleaner.clean_with(:truncation)
  end

  #config.include Ganttin::RSpecDeviseLogin, type: :controller
  config.include Ganttin::RSpecJsonRequest, type: :controller
  config.include Ganttin::RSpecAcceptVersionRequest, type: :request
  config.include Ganttin::RSpecAPIAuthRequest, type: :request
  config.include Ganttin::RSpecDatabaseCleaner
  #config.include Ganttin::RSpecAssetsCleaner

  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
