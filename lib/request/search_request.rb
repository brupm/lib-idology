module Idology
  class SearchRequest < Request

    def initialize
      # corresponds to an IDology ExpectID API call
      self.url = 'https://web.idologylive.com/api/idlive.svc'
      super
    end

    def set_data(subject)
      data_to_send = {
        :username => self.credentials.username,
        :password => self.credentials.password,
        :firstName => subject.firstName,
        :lastName => subject.lastName,
        :address => subject.address,
        :city => subject.city,
        :state => subject.state,
        :zip => subject.zip,
        :ssnLast4 => subject.ssnLast4,
        :dobMonth => subject.dobMonth,
        :dobYear => subject.dobYear,
        :uid => subject.userID
      }

      self.data = data_to_send
    end
  end
end