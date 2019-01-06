require 'spec_helper'
require './views/careers_email'

describe WorkForwardNola::Views::CareersEmail do
  # TODO: auto-generated
  describe '#career_descriptions' do
    it 'works' do
      careers_email = WorkForwardNola::Views::CareersEmail.new
      result = careers_email.career_descriptions
      expect(result).not_to be_nil
    end
  end
end
