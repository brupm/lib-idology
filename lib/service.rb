module Idology
  class Service
    attr_accessor :api_search_response, :api_question_response, :api_verification_response, :api_challenge_question_response, :api_challenge_verification_response

    def locate(subject)
      # locate is an IDology ExpectID API call - only checks to see if a person is available in the system
      # if available, further API calls can be made to verify the person's identity via ExpectID IQ questions

      # new SearchRequest Object
      search_request = SearchRequest.new

      # assemble the data in a hash for the POST
      search_request.set_data(subject)

      # make the call
      response = SearchResponse.new( ssl_post(search_request.url, search_request.data) )
      self.api_search_response = response

      return response

    rescue Exception => err
      log_error(err, 'locate()')

      # raise a generic error for the caller
      raise ServiceError
    end

    def get_questions(subject)
      # get_questions is an IDology ExpectID IQ API call - which given a valid idNumber from an ExpectID API call
      # should return three questions that can be asked to verify the ID of the person in question

      # new VerificationQuestionsRequest object
      question_request = VerificationQuestionsRequest.new

      # assemble the data in a hash for the POST
      question_request.set_data(subject)

      # make the call
      response = VerificationQuestionsResponse.new( ssl_post(question_request.url, question_request.data) )
      self.api_question_response = response

      return response

    rescue Exception => err
      log_error(err, 'get_questions()')

      # raise a generic error for the caller
      raise ServiceError
    end

    def submit_answers(subject)
      # submit questions / answers to the IDology ExpectID IQ API

      verification_request = VerificationRequest.new

      # assemble the data for POST
      verification_request.set_data(subject)

      # make the call
      response = VerificationResponse.new( ssl_post(verification_request.url, verification_request.data) )
      self.api_verification_response = response

      return response

    rescue Exception => err
      log_error(err, 'submit_answers()')

      # raise a generic error for the caller
      raise ServiceError
    end

    def get_challenge_questions(subject)
      # get_challenge_questions is an IDology ExpectID Challenge API call - given a valid idNumber from an ExpectID IQ question
      # and response process, will return questions to further verify the subject

      question_request = ChallengeQuestionsRequest.new

      # assemble the data
      question_request.set_data(subject)

      # make the call
      response = ChallengeQuestionsResponse.new( ssl_post(question_request.url, question_request.data) )
      self.api_challenge_question_response = response

      return response

    rescue Exception => err
      log_error(err, 'get_challenge_questions()')

      # raise a generic error for the caller
      raise ServiceError
    end

    def submit_challenge_answers(subject)
      # submit question type / answers to the IDology ExpectID Challenge API

      challenge_verification_request = ChallengeVerificationRequest.new

      # assemble the data
      challenge_verification_request.set_data(subject)

      # make the call
      response = ChallengeVerificationResponse.new( ssl_post(challenge_verification_request.url, challenge_verification_request.data) )
      self.api_challenge_verification_response = response

      return response

    rescue Exception => err
      log_error(err, 'submit_challenge_answers()')

      # raise a generic error for the caller
      raise ServiceError
    end


    private

    def ssl_post(url, data, headers = {})
      url = URI.parse(url)

      # create a Proxy class, incase a proxy is being used - will work even if proxy options are nil
      connection = Net::HTTP.new(url.host, url.port)

      connection.use_ssl = true

      if ENV['RAILS_ENV'] == 'production'
        # we want SSL enforced via certificates
        connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
        connection.ca_file = File.dirname(__FILE__) + "/certs/cacert.pem"
      else
        # do not enforce SSL in dev modes
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE

        # for debugging
        connection.set_debug_output $stderr
      end

      connection.start { |https|
        # setup the POST request
        req = Net::HTTP::Post.new(url.path)
        req.set_form_data(data, '&')

        # do the POST and return the response body
        return https.request(req).body
      }
    end

    def log_error(err, method_name)
      logger = Logger.new(File.dirname(__FILE__) + "/log/error.log")
      logger.error "IDology API Error in Service.#{method_name} - " + err.message
      logger.close
    end
  end
end