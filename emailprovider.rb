require './awsemailer.rb'
module WorkForwardNola
  # Sets up AWS SES variables through the environment file
  class EmailProvider
    @emailer = AwsEmailer.new ENV['AWS_ACCESS'], ENV['AWS_SECRET']
    @owner_email = ENV['OWNER_EMAIL'].freeze
    @sender_email = ENV['SENDER_EMAIL'].freeze

    class << self
      attr_reader :emailer
    end

    def self.sender
      @sender_email
    end

    def self.owner
      @owner_email
    end
  end
end
