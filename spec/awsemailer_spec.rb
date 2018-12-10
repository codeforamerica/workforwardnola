require 'spec_helper'
require './awsemailer'

describe WorkForwardNola::AwsEmailer do

  # TODO: auto-generated
  describe '#new' do
    it 'works' do
      access = double('access')
      secret = double('secret')
      result = WorkForwardNola::AwsEmailer.new(access, secret)
      expect(result).not_to be_nil
    end
  end

  # TODO: auto-generated
  describe.skip '#send_email' do
    it 'works' do
      access = double('access')
      secret = double('secret')
      aws_emailer = WorkForwardNola::AwsEmailer.new(access, secret)
      recipients = double('recipients')
      sender = double('sender')
      subject = double('subject')
      text_body = double('text_body')
      html_body = double('html_body')
      attachment_name = double('attachment_name')
      attachment_file = double('attachment_file')
      result = aws_emailer.send_email(recipients, sender, subject,
        text_body, html_body, attachment_name, attachment_file)
      expect(result).not_to be_nil
    end
  end
end
