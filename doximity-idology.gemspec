# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "doximity-idology"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bruno Miranda"]
  s.date = "2012-05-04"
  s.description = "Ruby interface to the IDology API"
  s.email = "bmiranda@doximity.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "doximity-idology.gemspec",
    "lib/access_credentials.rb",
    "lib/answer.rb",
    "lib/certs/cacert.pem",
    "lib/config.yml",
    "lib/error.rb",
    "lib/idology.rb",
    "lib/log/.gitignore",
    "lib/question.rb",
    "lib/request/challenge_questions_request.rb",
    "lib/request/challenge_verification_request.rb",
    "lib/request/request.rb",
    "lib/request/search_request.rb",
    "lib/request/verification_questions_request.rb",
    "lib/request/verification_request.rb",
    "lib/response/challenge_questions_response.rb",
    "lib/response/challenge_verification_response.rb",
    "lib/response/response.rb",
    "lib/response/search_response.rb",
    "lib/response/verification_questions_response.rb",
    "lib/response/verification_response.rb",
    "lib/service.rb",
    "lib/subject.rb",
    "spec/api_request_spec.rb",
    "spec/api_response_spec.rb",
    "spec/base_spec.rb",
    "spec/fixtures/1_answer_incorrect_response.xml",
    "spec/fixtures/2_answers_incorrect_response.xml",
    "spec/fixtures/3_answers_incorrect_response.xml",
    "spec/fixtures/all_answers_correct_challenge_response.xml",
    "spec/fixtures/all_answers_correct_response.xml",
    "spec/fixtures/challenge_questions_response.xml",
    "spec/fixtures/error_response.xml",
    "spec/fixtures/match_found_response.xml",
    "spec/fixtures/match_found_single_address.xml",
    "spec/fixtures/match_found_ssn_does_not_match.xml",
    "spec/fixtures/match_found_ssn_invalid.xml",
    "spec/fixtures/match_found_ssn_issued_prior_to_dob.xml",
    "spec/fixtures/match_found_ssn_unavailable.xml",
    "spec/fixtures/match_found_subject_deceased.xml",
    "spec/fixtures/match_found_thin_file.xml",
    "spec/fixtures/no_match_response.xml",
    "spec/fixtures/one_answer_incorrect_challenge_response.xml",
    "spec/fixtures/questions_response.xml",
    "spec/fixtures/sample_config.yml",
    "spec/fixtures/two_answers_incorrect_challenge_response.xml",
    "spec/fixtures/unknown_response.xml",
    "spec/fixtures/verification_timeout_response.xml",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/doximity/doximity"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "Ruby interface to the IDology API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0"])
  end
end

