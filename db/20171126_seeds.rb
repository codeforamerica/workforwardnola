require './models/trait'
require './models/career'

module WorkForwardNola
  Sequel.seed do
    def run
      [ 'Problem solver',
        'Working with your hands',
        'Teamwork',
        'Learner',
        'Detail oriented',
        'Following instructions',
        'Outgoing personality',
        'Work outdoors',
        'Physical Strength',
        'Helping people',
        'No fear of heights',
        'Open-minded',
        'Work on ground',
        'Individualistic',
        'Helpful'
      ].each do |name|
        Trait.create name: name
      end

      all_traits = Trait.map { |t| [t[:name], t[:id]] }.to_h

      help_desk = Career.create \
        name: 'Help Desk',
        sector: 'Tech',
        description: 'Provide technical assistance to computer users, resolve 
        problems for clients, provide assistance with computer hardware and 
        software.',
        experienced_range: '$25,000 - $35,000',
        entry_wage: '$14.42'
      ['Problem solver',
      ].each do |trait|
        help_desk.add_trait all_traits[trait]
      end
    end
  end
end