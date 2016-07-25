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
      
      office_assistant = Career.create \
        name: 'Office Assistant',
        sector: 'Other',
        description: 'Maintain office operations by received and distributing ' \
        'communications, maintaining supplies and equipment, picking up and delivering ' \
        'items, serving customers.',
        average_wage: 12.50,
        experienced_wage: 18.50
      ['Detail oriented', 'Self-starter', 'Customer service', 'Reliable'].each do |trait|
        office_assistant.add_trait all_traits[trait]
      end

      gardener = Career.create \
        name: 'Gardener',
        sector: 'Environmental Management',
        description: 'Carry out numerous gardening duties, requiring a minimum amount ' \
        'of supervision. Soil cultivation, digging, forking, mulching, watering, ' \
        'raking, weeding, edging, pruning, bed preparation, and planting.',
        average_wage: 13.50,
        experienced_wage: 16.50
      ['Working with your hands', 'Physical Strength', 'Following instructions'].each do |trait|
        gardener.add_trait all_traits[trait]
      end

      computer_support = Career.create \
        name: 'Computer Support Specialist',
        sector: 'IT',
        description: 'Give technical assistance to computer users. Answer questions or ' \
        'a solution for a client\'s computer problems in person, over the telephone, ' \
        'or electronically.',
        average_wage: 14.50,
        experienced_wage: 24.15,
        certification_required: true,
        training_money_available: true
      ['Working with your hands', 'Organized', 'Perceptive'].each do |trait|
        computer_support.add_trait all_traits[trait]
      end

      electrician = Career.create \
        name: 'Electrician',
        sector: 'IT',
        description: 'Read blueprints or technical diagrams. Install and maintain ' \
        'wiring, control, and lighting systems. Inspect electrical components, such ' \
        'as transformers and circuit breakers.',
        average_wage: 18.50,
        experienced_wage: 24.50,
        certification_required: true,
        training_money_available: true
      ['Following instructions', 'Adaptable', 'No fear of heights'].each do |trait|
        electrician.add_trait all_traits[trait]
      end
    end
  end
end
