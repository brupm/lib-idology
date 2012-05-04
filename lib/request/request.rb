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

    def initialize(credentials = { :username => 'test_username', :password => 'test_password'})
      # config = YAML::load(File.open(Request.config))
      # self.credentials = AccessCredentials.new(:username => config['username'], :password => config['password'])
      self.credentials = AccessCredentials.new(credentials)
    end
  end
end
