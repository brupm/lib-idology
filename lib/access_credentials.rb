module Idology
  class AccessCredentials
    attr_accessor :username, :password

    def initialize(credentials)
      self.username = credentials[:username]
      self.password = credentials[:password]
    end
  end
end