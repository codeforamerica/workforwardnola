require 'spec_helper'
require './emailer'

describe WorkForwardNola::Emailer do
  describe '#new' do
    it 'works' do
      result = WorkForwardNola::Emailer.new
      expect(result).not_to be_nil
      expect(result).to respond_to(:send_email)
    end
  end

  describe '#send_email' do
    it 'errors (abstract class without implementation)' do
      emailer = WorkForwardNola::Emailer.new
      expect{emailer.send_email}.to raise_error(
        WorkForwardNola::AbstractMethodImplementationMissingError,
        'Emailer is an abstract class. Please use an implementation class.')
    end
  end
end
