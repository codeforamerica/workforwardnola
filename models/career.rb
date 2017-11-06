module WorkForwardNola
  # model for Career object
  class Career < Sequel::Model
    many_to_many :traits

    def self.bulk_create(data)
      # clear careers table
      Career.db.run 'TRUNCATE careers CASCADE'
      # iterate over data & insert for each one
      all_traits = Trait.map { |t| [t[:spreadsheet_key], t[:id]] }.to_h

      data.each do |career|
        new_career = Career.create(
          name: career['name'],
          sector: career['sector'],
          experienced_range: career['experienced_range'],
          entry_wage: career['entry_wage'],
          foundational_skills: career['foundational_skills'],
          certification_required: career['certification_required'],
          description: career['description'],
          training: career['training']
        )

        # add traits
        career['traits'].split(',').each do |spreadsheet_key|
          new_career.add_trait all_traits[spreadsheet_key.to_i]
        end
      end
    end
  end
end
