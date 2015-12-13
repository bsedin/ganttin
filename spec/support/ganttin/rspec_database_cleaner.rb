module Ganttin
  module RSpecDatabaseCleaner
    extend ActiveSupport::Concern

    included do
      before(:each) do
        ::DatabaseCleaner.strategy = :transaction
      end

      before(:each, js: true) do
        ::DatabaseCleaner.strategy = :truncation
      end

      before(:each) do
        ::DatabaseCleaner.start
      end

      after(:each) do
        ::DatabaseCleaner.clean
      end
    end
  end
end
