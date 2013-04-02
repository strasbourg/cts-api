require 'net/http'
require 'uri'

class Api::Cts::V1::ApiCtsV1Controller < ApplicationController
  prepend_before_filter :log_request

  protected
  def current_ability
    @_current_ability ||= Cts::Ability.new
  end

  def log_request
    Thread.new do
      Net::HTTP.post_form URI('http://stats.strasbourg-data.fr/track'),
        {
          password: ENV['LOGGER_PASSWORD'],
          ip: request.env['HTTP_X_FORWARDED_FOR'],
          service: 'cts',
          path: request.path,
          params: params.except('controller', 'action', 'format', 'subdomain').to_query,
          time: Time.now.iso8601(3)
        }
    end
  end
end
