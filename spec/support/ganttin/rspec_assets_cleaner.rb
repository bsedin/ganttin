require 'fileutils'

module Ganttin
  module RSpecAssetsCleaner
    extend ActiveSupport::Concern

    included do
      after(:suite) do
        ::FileUtils.rm_rf(Engine.root.join('spec/dummy/public/system/assets/'))
      end
    end
  end
end
