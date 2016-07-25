require './models/career'

module WorkForwardNola
  module Views
    # logic for career results page
    class Careers < Layout
      attr_reader :title

      def career_descriptions
        Career.map do |career|
          {
            job_title: career.name,
            job_description: career.description,
            training_money_available: true,
            hourly: { now: to_money(career.median_wage * 0.80), 
                      six_months: to_money(career.median_wage) },
            yearly: { now: to_money(as_annual(career.median_wage * 0.80)), 
                      six_months: to_money(as_annual(career.median_wage)) }
          }
        end
      end

      private 

      # expecting float
      def to_money amount
        if amount >= 1000
          "$#{amount.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, '\0,')}"
        else
          sprintf '$%.2f', amount
        end
      end

      def as_annual amount
        (amount * 37 * 52).round 0
      end
    end
  end
end
