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
        it_me = @quiz_answers.select { |_trait, ans| ans.eql? 'me' }.keys
        # only select careers that match the "me" traits
        @career_matches = Career.where(traits: Trait.where(name: it_me))
                                .map do |career|
          {
            id: career.id,
            job_title: career.name,
            job_description: career.description,
            general_duties: career.general_duties,
            training: career.training,
            experienced_range: career.experienced_range,
            entry_wage: career.entry_wage,
            career_image: career.career_image,
            alt_title: career.alt_title,
            certification_required: career.certification_required,
            match_stats: trait_match_stats(it_me, career.traits)
          }
        end

        @career_matches = @career_matches.sort_by { |career| career[:match_stats][:score] }
                                         .reverse
                                         .first(3)
        @career_matches.each.with_index(1) { |match, i| match[:index] = i }

        @career_matches.first[:first] = true
        @career_matches.last[:last] = true
        @career_matches
      end

      def career_ids
        @career_matches.map { |career| career[:id] }
      end

      private

      def trait_match_stats(user_trait_names, career_traits)
        score = 0
        traits = []

        # loop through traits of the career and see how many match the ones the user selected
        career_traits.each do |trait|
          if user_trait_names.include?(trait.name)
            score += 1
            traits.push(name: trait.name)
          end
        end

        {
          score: score,
          traits: traits
        }
      end

      # expecting float
      # def to_money(amount)
      #  sprintf '$%.2f', amount
      # if needed, for putting commas in money format:
      # "$#{amount.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\0,')}"
      # end
    end
  end
end
