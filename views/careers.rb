require './models/career'
require './models/trait'

module WorkForwardNola
  module Views
    # logic for career results page
    class Careers < Layout
      attr_reader :title

      def career_descriptions
        # get all the "me" traits
        it_me = @quiz_answers.select{|trait, ans| ans.eql? 'me'}.keys
        # only select careers that match the "me" traits
        Career.where(traits: Trait.where(name: it_me)).map do |career|
          {
            job_title: career.name,
            job_description: career.description,
            average_wage: to_money(career.average_wage),
            experienced_wage: to_money(career.experienced_wage),
            training_money_available: career.training_money_available,
            certification_required: career.certification_required
          }
        end
      end

      private 

      # expecting float
      def to_money amount
        sprintf '$%.2f', amount
        # if needed, for putting commas in money format:
        # "$#{amount.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\0,')}"
      end
    end
  end
end
