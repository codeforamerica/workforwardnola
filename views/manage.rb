require './models/oppcenter'
module WorkForwardNola
  module Views
    class Manage < Layout
      attr_reader :title

      def opportunity
        OppCenter.all.map do |oc|
          {
            center: oc.center,
            name: oc.name,
            contact: oc.contact,
            address: oc.address,
            email: oc.email,
            phone: oc.phone
          }
        end
      end
    end
  end
end
