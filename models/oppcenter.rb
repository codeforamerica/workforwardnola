module WorkForwardNola
  class OppCenter < Sequel::Model
    #many_to_many :oppcenter

    #def self.bulk_create data
      # clear traits table
     # OppCenter.db.run 'TRUNCATE oppcenter CASCADE'
      # iterate over data & insert for each one
      #data.each do |oppcenter|
        #OppCenter.create name: trait['name'], spreadsheet_key: trait['id'] #edit oppcenter stuff here
      end
    end
  #end
#end
