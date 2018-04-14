module WorkForwardNola
  class OppCenter < Sequel::Model
    many_to_many :opp_centers

    def self.bulk_create data
     #clear oppcenter table
     OppCenter.db.run 'TRUNCATE oppcenters CASCADE'
     data.each do |opp_centers|
       opp_c = OppCenter.create(
                  center: opp_centers['center'],
                  name: opp_centers['name'],
                  address: opp_centers['address'],
                  email: opp_centers['email'],
                  phone: opp_centers['phone'])
      end
    end
  end
end
