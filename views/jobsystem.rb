require './models/oppcenter'
module WorkForwardNola
  module Views
    # logic for jobsystem.html/jobsystem.mustache
    class Jobsystem < Layout
      attr_reader :title
      def opportunity
        oppcenters = {}
        OppCenter.all.each do |oc|
          oppcenters[oc.center.to_sym] = {
            center: oc.center,
            name: oc.name,
            contact: oc.contact,
            address: oc.address,
            email: oc.email,
            phone: oc.phone
          }
        end
        oppcenters
      end
    end
  end
end
