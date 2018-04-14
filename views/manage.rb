require './models/oppcenter'
module WorkForwardNola
  module Views
    class Manage < Layout
      attr_reader :title

      def oppportunity
      {job1_name: opp_centers['name']}
      end

    end
  end
end
