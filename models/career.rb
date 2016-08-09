module WorkForwardNola
  class Career < Sequel::Model
    many_to_many :traits

    def self.bulk_create data
      # clear careers table
      Career.db.run 'TRUNCATE careers CASCADE'
      # iterate over data & insert for each one
      all_traits = Trait.map { |t| [t[:spreadsheet_key] , t[:id]] }.to_h

      data.each do |career|
        new_career = Career.create(
          name: career['name'],
          sector: career['sector'],
          experienced_wage: career['experienced_wage'],
          ## this is a hack, we need to have the data ##
          average_wage: (career['average_wage'].empty? ? -1 : career['average_wage']),
          training_money_available: career['training_money_available'],
          certification_required: career['certification_required'],
          description: career['description'])

        # add traits
        career['traits'].split(',').each do |spreadsheet_key|
          new_career.add_trait all_traits[spreadsheet_key.to_i]
        end
      end
    end
  end
end