module Idology
  class SearchResponse < Response
    attr_accessor :qualifiers

    def initialize(raw_xml)
      super

      self.qualifiers = {}

      # get any qualifiers that are present
      if ! (self.parsed_response/:qualifiers).empty?
        returned_qualifiers = (self.parsed_response/:qualifiers)/:qualifier

        returned_qualifiers.each do |qualifier|
          self.qualifiers[(qualifier/:key).inner_text] = (qualifier/:message).inner_text
        end
      end
    end

    def eligible_for_verification?
      if ! (self.parsed_response/"eligible-for-questions").empty?
        (self.result_key == "result.match") && ((self.parsed_response/"eligible-for-questions").inner_text == "true") && ! flagged_qualifier?
      else
        false
      end
    end


    private

    def flagged_qualifier?
      # these qualifier messages mean the subject is cannot be asked questions
      # they come from the Admin section of the IDology account, and can be changed if needed

      flagged = ["Subject is Deceased", "SSN unavailable", "SSN4 Does Not Match", "SSN Issued Prior to DOB", "SSN Is Invalid", "Single Address in File"]

      self.qualifiers.values.each do |value|
        if flagged.include?(value)
          return true
        end
      end

      # no flagged qualifier found
      return false
    end

  end
end