require './models/career'
require './models/trait'

module WorkForwardNola
  module Views
    # logic for career results page
    class CareersEmail  < Mustache
      @career_matches = []

      def career_descriptions
        # only select careers that match the pre-specified IDs
        @career_matches = Career.where(id: @career_ids)
                                .map do |career|
          {
            job_title: career.name,
            job_description: career.description,
            foundational_skills: career.foundational_skills,
            training: career.training,
            experienced_wage: career.experienced_wage,
            entry_wage: career.entry_wage,
            certification_required: career.certification_required
          }
        end

        @career_matches
      end

      private

      # expecting float
      #def to_money(amount)
       # sprintf '$%.2f', amount
        # if needed, for putting commas in money format:
        # "$#{amount.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\0,')}"
      end

    end
  end
#end
