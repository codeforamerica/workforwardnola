module WorkForwardNola
  module Views
    # logic for showing woofound images
    class Woofound < Layout
      attr_reader :title

      def images
        [
          { id: 1,
            title: 'Working with technology',
            file: 'computer-user.jpg' },
          { id: 2,
            title: 'Working outside',
            file: 'Gardening-LB0507-1124.jpg' }
        ]
      end
    end
  end
end
