module Idology
  class ChallengeVerificationResponse < Response
    attr_accessor :idliveq_challenge_result_key, :idliveq_challenge_result_message

    def initialize(raw_xml)
      super

      # look for an error first
      if ! (self.parsed_response/"idliveq-challenge-error").empty?

        error = self.parsed_response/"idliveq-challenge-error"
        self.idliveq_challenge_result_key = (error/:key).inner_text
        self.idliveq_challenge_result_message = (error/:message).inner_text

      elsif ! (self.parsed_response/"idliveq-challenge-result").empty?

        # there was some sort of response
        result = self.parsed_response/"idliveq-challenge-result"
        self.idliveq_challenge_result_key = (result/:key).inner_text
        self.idliveq_challenge_result_message = (result/:message).inner_text

      else

        # an unexpected response
        self.idliveq_challenge_result_key = "error"
        self.idliveq_challenge_result_message = "The API returned an unexpected error."

      end
    end

    def verified?
      case self.idliveq_challenge_result_key
        when "error"
          # if there are any errors, fail right away
          return false
        when "result.timeout"
          # timeouts fail right away
          return false
        when "result.challenge.0.incorrect"
          # all correct passes
          return true
        when "result.challenge.1.incorrect"
          # one incorrect answer fails
          return false
        when "result.challenge.2.incorrect"
          # two incorrect fails
          return false
        else
          # fail by default
          return false
      end
    end

  end
end