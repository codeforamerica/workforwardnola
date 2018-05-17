require './awsemailer.rb'
module WorkForwardNola
    # Sets up AWS SES variables through the environment file
    class EmailProvider
        @@emailer = AwsEmailer.new ENV['AWS_ACCESS'], ENV['AWS_SECRET']
        @@ownerEmail = ENV['OWNER_EMAIL']
        @@senderEmail = ENV['SENDER_EMAIL']

        def self.emailer
            @@emailer
        end
        
        def self.sender
            @@senderEmail
        end

        def self.owner
            @@ownerEmail
        end
    end
end
