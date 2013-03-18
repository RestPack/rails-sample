require 'restpack-web'

class ApplicationController < ActionController::Base
  include RestPack::Web::Rails::Controller

  protected

  def authenticate!
    redirect_to '/' unless @restpack.is_authenticated?
  end

  def api
    @api ||= RestPack::Group::Client::Api.new(use_https: false, password: ENV['RESTPACK_ACCESS_KEY'], domain: ENV['RESTPACK_GROUP_SERVICE'])
  end
end