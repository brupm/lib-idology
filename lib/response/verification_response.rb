module Idology
  class VerificationResponse < Response
    attr_accessor :idliveq_result_key, :idliveq_result_message

    def initialize(raw_xml)
      super

      # look for an error first
      if ! (self.parsed_response/"idliveq-error").empty?

        error = self.parsed_response/"idliveq-error"
        self.idliveq_result_key = (error/:key).inner_text
        self.idliveq_result_message = (error/:message).inner_text

      elsif ! (self.parsed_response/"idliveq-result").empty?

        # there was some sort of response
        result = self.parsed_response/"idliveq-result"
        self.idliveq_result_key = (result/:key).inner_text
        self.idliveq_result_message = (result/:message).inner_text

      else

        # an unexpected response
        self.idliveq_result_key = "error"
        self.idliveq_result_message = "The API returned an unexpected error."

      end
    end

    def verified?
      case self.idliveq_result_key
        when "error"
          # if there are any errors, fail right away
          return false
        when "result.timeout"
          # timeouts fail right away
          return false
        when "result.questions.0.incorrect"
          # all correct passes
          return true
        when "result.questions.1.incorrect"
          # one incorrect answer passes
          return true
        when "result.questions.2.incorrect"
          # two incorrect passes, but we will challenge
          return true
        when "result.questions.3.incorrect"
          # three incorrect fails
          return false
        else
          # fail by default
          return false
      end
    end

    def challenge?
      # the logic for challenge questions is not relayed via the API, so we must set the logic here

      # do we need to ask 2 follow-up challenge questions? - only when 1/3 questions were correct
      self.idliveq_result_key == "result.questions.2.incorrect"
    end

  end
end