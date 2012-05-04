module Idology
  class Question
    attr_accessor :prompt, :type, :candidate_answers, :chosen_answer

    def initialize
      self.prompt = self.type = ""
      self.candidate_answers = []
    end
  end
end