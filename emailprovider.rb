require './awsemailer.rb'

module WorkForwardNola
    class EmailProvider
        @@emailer = AwsEmailer.new ENV['AWS_ACCESS'], ENV['AWS_SECRET']
        @@senderEmail = ENV['SENDER_EMAIL']
        @@ownerEmail = ENV['OWNER_EMAIL']
        
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
