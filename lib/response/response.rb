require 'hpricot'

module Idology
  class Response
    attr_accessor :raw_response, :parsed_response, :result_key, :result_message, :id_number

    def initialize(raw_xml)

      # parse the raw xml
      self.raw_response = raw_xml
      self.parsed_response = Hpricot.XML(raw_xml)

      # determine what common results were sent back
      if ! (self.parsed_response/:error).empty?

        # first check for an error
        self.result_key = "error"
        self.result_message = (self.parsed_response/:error).inner_text

      elsif ! (self.parsed_response/:results).empty?

        # the api responded with something
        results = self.parsed_response/:results
        self.result_key = (results/:key).inner_text
        self.result_message = (results/:message).inner_text

        # the ID to be used in further API calls
        self.id_number = (self.parsed_response/"id-number").inner_text

      else

        # something else unexpected was returned
        self.result_key = "error"
        self.result_message = "The API returned an unexpected error."

      end

    end
  end
end