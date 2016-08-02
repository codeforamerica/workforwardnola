require './models/career'
require './models/trait'

module WorkForwardNola
  module Views
    # logic for career results page
    class Careers < Layout
      @career_matches = []

      attr_reader :title

      def career_count
        @career_matches.count
      end

      def career_descriptions
        # get all the "me" traits
        it_me = @quiz_answers.select{|trait, ans| ans.eql? 'me'}.keys
        # only select careers that match the "me" traits
        @career_matches = Career.where(traits: Trait.where(name: it_me))
                                .map.with_index(1) do |career, i|
          {
            job_title: career.name,
            job_description: career.description,
            average_wage: to_money(career.average_wage),
            experienced_wage: to_money(career.experienced_wage),
            training_money_available: career.training_money_available,
            certification_required: career.certification_required,
            index: i
          }
        end

        @career_matches.first[:first] = true
        @career_matches.last[:last] = true
        @career_matches
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
