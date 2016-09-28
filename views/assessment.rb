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
            alt: 'Person is looking at a recipe on a computer before they begin chopping vegetables',
            file: 'instructions.jpg' },
          { trait: 'Working with your hands',
            reverse_trait: 'Technical',
            title: 'Working with your hands',
            alt: 'Person has a screwdriver and wrench in their hands and is working on mechanical parts',
            file: 'withhands.jpg' },
          { trait: 'Teamwork',
            reverse_trait: 'Researcher',
            title: 'Working on a team',
            alt: 'Two people are looking at a computer screen together',
            file: 'teamwork.jpg' },
          { trait: 'Working well under pressure',
            title: 'Working under a deadline',
            alt: 'A person checks their watch while working on a computer. They are surrounded by papers',
            file: 'underpressure.jpg' },
          { trait: 'Customer service',
            title: 'Working with customers',
            alt: 'Person is sitting behind a desk helping a customer fill out paperwork',
            file: 'customerservice.jpg' },
          { trait: 'Repetition',
            reverse_trait: 'Adaptable',
            title: 'Following a routine every day',
            alt: 'Person is driving a bus',
            file: 'routine.jpg' },
          { trait: 'Organized',
            title: 'Being well-organized',
            alt: 'Picture of a well-organized closet',
            file: 'organized.jpg' },
          { trait: 'No fear of heights',
            title: 'Comfortable with heights',
            alt: 'Person is working on power lines several feet off the ground',
            file: 'heights.jpg' },
          { trait: 'Detail oriented',
            title: 'Paying attention to details',
            alt: 'Person is using a magnifying glass to look over documents',
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
