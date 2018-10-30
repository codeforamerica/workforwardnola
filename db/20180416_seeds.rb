require './models/trait'
require './models/career'
require './models/oppcenter'

module WorkForwardNola
  Sequel.seed do
    # rubocop:disable Metrics/MethodLength
    def run
      ['Problem solver',
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
       'Helpful'].each do |name|
        Trait.create name: name
      end

      all_traits = Trait.map { |t| [t[:name], t[:id]] }.to_h

      OppCenter.create \
        center: 'job1',
        name: 'JOB1',
        contact: 'Name Ofperson',
        address: '3400 Tulane Avenue, New Orleans, LA 70118',
        phone: '504.658.4500',
        email: 'name@job1.org'

      OppCenter.create \
        center: 'goodwill',
        name: 'Goodwill Industries',
        contact: 'Person Name',
        address: '3400 Tulane Avenue, New Orleans, LA 70119',
        phone: '504.456.2662',
        email: 'Mail@goodwill.org'

      OppCenter.create \
        center: 'tca',
        name: 'Total Community Action',
        contact: 'Similar Name',
        address: '1340 S. Jefferson Davis Parkway, New Orleans, LA 70125',
        phone: '504.872.0334',
        email: 'Mail2@tca.org'

      help_desk = Career.create \
        name: 'Help Desk',
        sector: 'Tech',
        description: 'Provide technical assistance to computer users, resolve
        problems for clients, provide assistance with computer hardware and
        software.',
        experienced_range: '$25,000 - $35,000',
        entry_wage: '$14.42',
        career_image: 'help_desk.jpg',
        alt_title: 'Person is wearing a headset and looking at a computer'
      ['Problem solver'].each do |trait|
        help_desk.add_trait all_traits[trait]
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
