module WorkForwardNola
  module Views
    # logic for showing assessment images
    class Assessment < Layout
      attr_reader :title

      def images
        [
          { trait: 'Following instructions',
            reverse_trait: 'Self-starter',
            title: 'Following instructions',
            file: 'instructions.jpg' },
          { trait: 'Working with your hands',
            reverse_trait: 'Technical',
            title: 'Working with your hands',
            file: 'withhands.jpg' },
          { trait: 'Teamwork',
            reverse_trait: 'Researcher',
            title: 'Working on a team',
            file: 'teamwork.jpg' },
          { trait: 'Working well under pressure',
            title: 'Working under a deadline',
            file: 'underpressure.jpg' },
          { trait: 'Customer service',
            title: 'Working with customers',
            file: 'customerservice.jpg' },
          { trait: 'Repetition',
            reverse_trait: 'Adaptable',
            title: 'Following a routine every day',
            file: 'routine.jpg' },
          { trait: 'Organized',
            title: 'Being well-organized',
            file: 'organized.jpg' },
          { trait: 'No fear of heights',
            title: 'Comfortable with heights',
            file: 'heights.jpg' },
          { trait: 'Detail oriented',
            title: 'Paying attention to details',
            file: 'detail.jpg' }
        ]
      end

      def compound_traits
        [
          { trait: 'Perceptive',
            components: ['Detail oriented', 'Customer service'] },
          { trait: 'Physical Strength',
            components: ['Working with your hands', 'No fear of heights'] },
          { trait: 'Reliable',
            components: ['Working well under pressure', 'Organized'] },
          { trait: 'Leadership',
            components: ['Teamwork', 'Self-starter'] }
        ]
      end
    end
  end
end
