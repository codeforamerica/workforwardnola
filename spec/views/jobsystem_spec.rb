require 'spec_helper'
require './views/jobsystem'

describe WorkForwardNola::Views::Jobsystem do
  # TODO: auto-generated
  describe '#opportunity' do
    it 'works' do
      jobsystem = WorkForwardNola::Views::Jobsystem.new
      result = jobsystem.opportunity
      expect(result).not_to be_nil
    end
  end
end
