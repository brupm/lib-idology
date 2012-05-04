module Idology
  class VerificationQuestionsResponse < Response
    attr_accessor :questions

    def initialize(raw_xml)
      super

      # :quesiton returns the array of individual questions, while :questions (plural) contains that array
      returned_questions = ((self.parsed_response/:questions)/:question)

      # parse the questions and answers returned
      if self.result_key == "result.match" && ! returned_questions.empty?

        self.questions = []

        returned_questions.each do |question|
          q = Question.new

          q.prompt = (question/:prompt).inner_text
          q.type = (question/:type).inner_text

          answers = question/:answer
          answers.each { |answer| q.candidate_answers << Answer.new(answer.inner_text) }

          self.questions << q
        end
      end

    end
  end
end