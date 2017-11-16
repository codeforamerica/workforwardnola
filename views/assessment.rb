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
            # alt text describing image, for accessibility
            alt: 'Person is wearing a headset and looking at a computer',
            file: 'help_desk.jpg' }, # name ofimage in /assets/images/assessment
          { trait: 'Working with your hands',
            reverse_trait: 'Work on ground',
            title: 'Working with your hands',
            alt: 'Person using tools to work on mechanical parts',
            file: 'withhands.jpg' },
          { trait: 'Teamwork',
            reverse_trait: 'Helpful',
            title: 'Working on a team',
            alt: 'Multiple hands are working on computers together',
            file: 'teamwork.jpg' },
          { trait: 'Learner',
            reverse_trait: 'Helpful',
            title: 'Learning new things',
            alt: 'Person sitting in front of a computer',
            file: 'junior_programmer.jpg' },
          { trait: 'Following instructions',
            reverse_trait: 'Open-minded',
            title: 'Following instructions',
            alt: 'Person is sitting at a desk helping customer fill out paper',
            file: 'customerservice.jpg' },
          { trait: 'Outgoing personality',
            reverse_trait: 'Individualistic',
            title: 'Outgoing personality',
            alt: 'Person loading on a patient in a wheelchair into a van',
            file: 'patient_driver.jpg' },
          { trait: 'Work outdoors',
            reverse_trait: 'Work on ground',
            title: 'Work outdoors',
            alt: 'Person is holding a wrench and smiling',
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

            alt: 'Person wearing construction gear along with co-workers',
            file: 'laborer.jpg' },
          { trait: 'Helping people',
            reverse_trait: 'Physical Strength',
            title: 'Helping people',
            alt: 'Nurse is holding a clipboard and smiling',
            file: 'housekeeping_aide.jpg' }
        ]
      end
      
      def compound_traits
        [
          { trait: 'Open-minded', # name of trait
            components: ['Problem solver', # component traits taken from above
                         'Learner'] },
          { trait: 'Physical Strength',
            components: ['Working with your hands', 'No fear of heights'] },
          { trait: 'Work on ground',
            components: ['Learner', 'Problem solver', 'Detail oriented', 
                         'Outgoing personality', 'Following Instructions', 
                         'Helping people'] },
          { trait: 'Individualistic',
            components: ['Learner', 'Problem solver', 'Working outdoors', 
                         'Working with your hands', 'No fear of heights'] },
          { trait: 'Helpful',
            components: ['Outgoing personality', 'Following instructions', 
                         'Helping people'] }
        ]
      end
    end
  end
end
