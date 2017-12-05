require './awsemailer.rb'
require './app.rb'

module WorkForwardNola  
  class Emailer
    def initialize
    end
    
    def send_email
      throw Error("Emailer is an abstract class. Please use an implementation class.")
    end
  end
end