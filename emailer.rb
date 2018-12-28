# require './awsemailer.rb'
# require './app.rb'

module WorkForwardNola
  # Abstract class for emailing systems
  class Emailer
    def initialize; end

    def send_email
      raise WorkForwardNola::AbstractMethodImplementationMissingError.new(
        'Emailer is an abstract class. Please use an implementation class.')
    end
  end

  class AbstractMethodImplementationMissingError < NoMethodError
  end
end
