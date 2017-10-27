module WorkForwardNola
  module Views
    # logic for showing assessment images
    class Assessment < Layout
      attr_reader :title
      
      def images
        [
          { trait: 'Problem solver', # must match name of trait, 'me' result
            reverse_trait: 'Following instructions', # optional, 'not me' result
            title: 'Solving problems', # text to display with image
            alt: 'Person is sitting in a chair looking at a computer', # text describing image, for accessibility
            file: 'help_desk.jpg' }, # file name of image in /assets/images/assessment or /assets/images/careers
          { trait: 'Working with your hands',
            reverse_trait: 'Work on ground',
            title: 'Working with your hands',
            alt: 'Person has a screwdriver and wrench in their 
                hands and is working on mechanical parts',
            file: 'withhands.jpg' },
          { trait: 'Teamwork',
            reverse_trait: 'Helpful',
            title: 'Working on a team',
            alt: 'Two people are looking at a computer screen together',
            file: 'teamwork.jpg' },
          { trait: 'Learner',
            reverse_trait: 'Helpful',
            title: 'Learning new things',
            alt: 'A person sitting in a chair in front of a computer screen',
            file: 'service_desk.jpg' },
          { trait: 'Following instructions',
            reverse_trait: 'Open-minded',
            title: 'Following instructions',
            alt: 'Person is sitting behind a desk helping 
                  a customer fill out paperwork',
            file: 'customerservice.jpg' },
          { trait: 'Outgoing personality',
            reverse_trait: 'Individualistic',
            title: 'Outgoing personality',
            alt: 'Person is loading on a patient on a wheelchair 
                 into the back of a van',
            file: 'patient_driver.jpg' },
          { trait: 'Work outdoors',
            reverse_trait: 'Work on ground',
            title: 'Work outdoors',
            alt: 'Person is holding a wrench tool and smiling',
            file: 'plumber.jpg' },
          { trait: 'No fear of heights',
            reverse_trait: 'Work on ground',
            title: 'Comfortable with heights',
            alt: 'Person is working on power lines several feet off the ground',
            file: 'heights.jpg' },
          { trait: 'Detail oriented',
            reverse_trait: 'Physical Strength',
            title: 'Paying attention to details',
            alt: 'Person is using a magnifying glass to look over documents',
            file: 'detail.jpg' },
          { trait: 'Physical Strength',
            reverse_trait: 'Helping people',
            title: 'Physical strength',
            alt: 'Person is smiling with construction gear on along with his co-workers',
            file: 'laborer.jpg' },
          { trait: 'Helping people',
            reverse_trait: 'Physical Strength',
            title: 'Helping people',
            alt: 'Person delivering food to a patient on a hospital bed',
            file: 'food_delivery.jpg' }
        ]
      end


      def compound_traits
        [
          { trait: 'Open-minded', # name of trait
            components: ['Problem solver', 'Learner'] }, # these traits are in the images list above
          { trait: 'Physical Strength',
            components: ['Working with your hands', 'No fear of heights'] },
          { trait: 'Work on ground',
            components: ['Learner', 'Problem solver', 'Detail oriented', 'Outgoing personality', 'Following Instructions', 'Helping people'] },
          { trait: 'Individualistic',
            components: ['Learner', 'Problem solver', 'Working outdoors', 'Working with your hands', 'No fear of heights'] },
          { trait: 'Helpful',
            components: ['Outgoing personality', 'Following instructions', 'Helping people'] }
        ]
      end
    end
  end
end
