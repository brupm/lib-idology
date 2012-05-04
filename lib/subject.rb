module Idology
  class Subject
    attr_accessor :firstName, :lastName, :address, :city, :state, :zip, :ssnLast4, :dobMonth, :dobYear, :userID
    attr_accessor :idNumber, :api_service, :qualifiers
    attr_accessor :verification_questions, :eligible_for_verification, :verified, :challenge
    attr_accessor :challenge_questions

    def initialize(data = nil)
      self.api_service = Service.new
      self.verified = self.challenge = self.eligible_for_verification = false
      self.qualifiers = ""

      if data
        self.firstName = data[:firstName]
        self.lastName = data[:lastName]
        self.address = data[:address]
        self.city = data[:city]
        self.state = data[:state]
        self.zip = data[:zip]
        self.ssnLast4 = data[:ssnLast4]
        self.dobMonth = data[:dobMonth]
        self.dobYear = data[:dobYear]
        self.userID = data[:userID]
      end
    end

    def locate
      response = self.api_service.locate(self)

      self.idNumber = response.id_number
      self.eligible_for_verification = response.eligible_for_verification?

      # we must track any qualifiers that come back
      if ! response.qualifiers.empty?
        self.qualifiers = response.qualifiers.values.join("|")
      end

      return true

    rescue ServiceError
      return false
    end

    def get_questions
      response = self.api_service.get_questions(self)
      self.verification_questions = response.questions

      return true

    rescue ServiceError
      return false
    end

    def submit_answers
      response = self.api_service.submit_answers(self)
      self.verified = response.verified?
      self.challenge = response.challenge?

      return true

    rescue ServiceError
      return false
    end

    def get_challenge_questions
      response = self.api_service.get_challenge_questions(self)
      self.challenge_questions = response.questions

      return true

    rescue ServiceError
      return false
    end

    def submit_challenge_answers
      response = self.api_service.submit_challenge_answers(self)
      self.verified = response.verified?

      return true

    rescue ServiceError
      return false
    end


    # for debugging
    def set_match
      # this is a test record that will be found
      self.firstName = 'Spider'
      self.lastName = 'Man'
      self.address = '321 Orange Dr'
      self.city = 'Miami'
      self.state = 'FL'
      self.zip = 33134
      self.ssnLast4 = 1333
      self.dobMonth = 1
      self.dobYear = 1950

      return "set to Spider Man"
    end

    def set_no_match
      # this guy does not exist
      self.firstName = 'DoesNot'
      self.lastName = 'Exist'
      self.address = '123 Main St'
      self.city = 'Nowhere'
      self.state = 'NY'
      self.zip = 10001
      self.ssnLast4 = 1234
      self.dobMonth = 1
      self.dobYear = 1965

      return "set to DoesNot Exist"
    end

    def show_questions
      # display the question.prompt and question.candidate_answers
      if ! self.verification_questions.empty?
        count = 0
        self.verification_questions.each do |question|
          puts count.to_s + " - " + question.prompt + ": \n"

          question.candidate_answers.each do |answer|
            puts "   - " + answer.text + "\n"
          end

          count += 1
        end
      end

      return "\n"
    end

    def show_challenge_questions
      # display the question.prompt and question.candidate_answers
      if ! self.challenge_questions.empty?
        count = 0
        self.challenge_questions.each do |question|
          puts count.to_s + " - " + question.prompt + ": \n"

          question.candidate_answers.each do |answer|
            puts "   - " + answer.text + "\n"
          end

          count += 1
        end
      end

      return "\n"
    end

  end
end