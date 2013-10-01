require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  raise "cannot run tests in production" if ENV["RAILS_ENV"] == 'production'
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec'
  require 'database_cleaner'
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/spec_helpers/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/shared_examples/**/*.rb")].each { |f| require f }

  FactoryGirl.definition_file_paths = %w(spec/factories)
  DatabaseCleaner.strategy = :transaction

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:twitter, {
    provider: 'twitter',
    uid:      '123545',
    info: {
      nickname: 'omniauth',
      name:     'omniauth',
      image:    'http://omniauth.com/image.png'
    },
    credentials: {
      token:  '80e3aad93519dcd3',
      secret: '29293db8cf6bca8eeb16bccba7df7179'
    }
  })

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true

    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    config.before(:suite) { FactoryGirl.reload }

    config.include(FactoryGirl::Syntax::Methods)
  end

end

Spork.each_run do
  FactoryGirl.reload
  DatabaseCleaner.clean
  Timecop.return
end
