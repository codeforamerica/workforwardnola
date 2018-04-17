module WorkForwardNola
    class OppCenter < Sequel::Model

        def self.bulk_create data
        #clear oppcenter table
            OppCenter.db.run 'TRUNCATE oppcenters CASCADE'
            data.each do |opp_c|
            OppCenter.create(
                      center: opp_c['center'],
                      name: opp_c['name'],
                      address: opp_c['address'],
                      email: opp_c['email'],
                      phone: opp_c['phone'],
                      contact: opp_c['contact'])
            end
        end
    end
end
