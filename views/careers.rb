module WorkForwardNola
  module Views
    # logic for career results page
    class Careers < Layout
      attr_reader :title

      def career_descriptions
        [
          {
            job_title: 'Electrician',
            job_description: 'Read blueprints or technical diagrams. Install '\
            'and maintain wiring, control, and lighting systems. Inspect '\
            'electrical components, such as transformers and circuit breakers.',
            training_money_available: true,
            hourly: { now: '0', six_months: '16.83', two_years: '25.00' },
            yearly: { now: '0', six_months: '35,000', two_years: '52,000' }
          },
          {
            job_title: 'Computer Support Specialist',
            job_description: 'Computer Support Specialists provide technical '\
            'assistance to computer users. Answer questions or resolve computer'\
            ' problems for clients in person, or via telephone or '\
            'electronically.',
            training_money_available: false,
            hourly: { now: '0', six_months: '14.50', two_years: '20.50' },
            yearly: { now: '0', six_months: '30,160', two_years: '42,640' }
          }
        ]
      end
    end
  end
end
