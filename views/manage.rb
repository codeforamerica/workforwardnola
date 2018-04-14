require './models/oppcenter'
module WorkForwardNola
  module Views
    class Manage < Layout
      attr_reader :title

      def oppportunity
      { job1_name: OppCenter.oppcenters.job1_name}
      end

    end
  end
end
