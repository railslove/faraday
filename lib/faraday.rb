require 'faraday/autoload_helper'

module Faraday
  extend AutoloadHelper

  VERSION = "0.5.3"

  class << self
    attr_accessor :default_adapter
    attr_writer   :default_connection

    private

    def method_missing(name, *args, &block)
      default_connection.send(name, *args, &block)
    end
  end

  self.default_adapter = :net_http

  def self.default_connection
    @default_connection ||= Connection.new
  end

  autoload_all 'faraday',
    :Middleware      => 'middleware',
    :Builder         => 'builder',
    :Request         => 'request',
    :Response        => 'response',
    :CompositeReadIO => 'upload_io',
    :UploadIO        => 'upload_io',
    :Parts           => 'upload_io'
end

require 'faraday/utils'
require 'faraday/connection'
require 'faraday/adapter'
require 'faraday/error'
require 'faraday/ext/object'