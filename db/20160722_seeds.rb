require './models/trait'
require './models/career'
module WorkForwardNola

  Sequel.seed do
    def run
      [
        'Detail oriented',
        'Working with your hands',
        'Teamwork',
        'Organized',
        'Working well under pressure',
        'Following instructions',
        'Customer service',
        'Technical',
        'Physical Strength',
        'Reliable',
        'Repetition',
        'No fear of heights',
        'Adaptable',
        'Self-starter',
        'Leadership',
        'Perceptive',
        'Researcher'
      ].each do |name|
        Trait.create name: name
      end

      all_traits = Trait.map { |t| [t[:name] , t[:id]] }.to_h
      
      welder = Career.create \
        name: 'Welder',
        sector: 'Advanced Manufacturing',
        description: 'oh look a description',
        median_wage: 21.75
      ['Detail oriented', 'Working with your hands', 'Physical Strength', 'Reliable'].each do |trait|
        welder.add_trait all_traits[trait]
      end

      machinist = Career.create \
        name: 'Machinist',
        sector: 'Advanced Manufacturing',
        description: 'Machinists machine things.',
        median_wage: 21.25
      ['Detail oriented', 'Technical', 'Following instructions'].each do |trait|
        machinist.add_trait all_traits[trait]
      end
    end
  end
end
