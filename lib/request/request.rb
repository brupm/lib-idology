require 'yaml'

module Idology
  class Request
    attr_accessor :url, :credentials, :data

    class << self
      attr_accessor :config
    end

    # test for config file
    if ! File.exist?(File.dirname(__FILE__) + "/../config.yml")
      raise Exception, "config file for API::IDVerification not present - try reading the README file"
    end

    # must be in the same directory as this file
    self.config = File.dirname(__FILE__) + "/../config.yml"

    def initialize
      config = YAML::load(File.open(Request.config))
      self.credentials = AccessCredentials.new(:username => config['username'], :password => config['password'])
    end
  end
end