require 'hashie-forbidden_attributes'
require_relative 'helpers/auth_helper'

module Ganttin
  module API
    class V1 < ::Grape::API
      version 'v1', using: :accept_version_header, strict: true
      content_type :json, 'application/json'
      format :json
      formatter :json, Grape::Formatter::Rabl
      default_error_formatter :json

      helpers ::Ganttin::API::AuthHelper

      rescue_from ActiveRecord::RecordNotFound do |e|
        error! e, 404
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error! e, 400
      end

      helpers do
        def permitted_params
          declared(params)
        end

        def page
          unless headers['Range'].blank?
            headers['Range'].match(/(?:items )?(\d+)\-(\d+)/) do |m|
              p = m[1].to_i / WillPaginate.per_page + 1
              return p if p >= 1
            end
          end
          1
        end

        def ensure_range_headers_for(collection)
          header 'Accept-Ranges', 'items'
          header 'Range-Unit', 'items'
          total_entries = collection.total_entries.to_i
          if total_entries > 0
            limit = WillPaginate.per_page * page - 1
            header 'Content-Range', "#{collection.offset}-#{limit}/#{total_entries}"
          else
            header 'Content-Range', '*/0'
          end
        end
      end

      desc 'Status page'
      get '/status' do
        { status: 'ok', date: Time.now }
      end

      mount V1::Auth
      mount V1::Profile
      mount V1::Projects
      mount V1::Tasks
      mount V1::TaskStages
    end
  end
end
