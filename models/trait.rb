module WorkForwardNola
  # Model class for Traits
  class Trait < Sequel::Model
    many_to_many :careers

    def self.bulk_create(data)
      # clear traits table
      Trait.db.run 'TRUNCATE traits CASCADE'
      # iterate over data & insert for each one
      data.each do |trait|
        Trait.create name: trait['name'], spreadsheet_key: trait['id']
      end
    end
  end
end
