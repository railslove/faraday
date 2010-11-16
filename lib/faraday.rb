module Faraday
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

  module AutoloadHelper
    def register_lookup_modules(mods)
      (@lookup_module_index ||= {}).update(mods)
    end

    def lookup_module(key)
      return if !@lookup_module_index
      const_get @lookup_module_index[key] || key
    end

    def autoload_all(prefix, options)
      options.each do |const_name, path|
        autoload const_name, File.join(prefix, path)
      end
    end

    # Loads each autoloaded constant.  If thread safety is a concern, wrap
    # this in a Mutex.
    def load_autoloaded_constants
      constants.each do |const|
        const_get(const) if autoload?(const)
      end
    end

    def all_loaded_constants
      constants.map { |c| const_get(c) }.
        select { |a| a.respond_to?(:loaded?) && a.loaded? }
    end
  end

  extend AutoloadHelper

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