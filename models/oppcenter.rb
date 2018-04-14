module WorkForwardNola
  class OppCenter < Sequel::Model
    many_to_many :oppcenters

    def self.bulk_create data
     #clear oppcenter table
     OppCenter.db.run 'TRUNCATE oppcenters CASCADE'
     OppCenter.create(
                tca_name: 'test',
                tca_address: 'test',
                tca_email: 'test',
                tca_phone: 'test',
                goodwill_name: 'test',
                goodwill_address: 'test',
                goodwill_email: 'test',
                goodwill_phone: 'test',
                job1_name: 'test',
                job1_address: 'test',
                job1_email: 'test',
                job1_phone: 'nil')
    end
  end
end
