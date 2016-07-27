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
            file: 'Gardening-LB0507-1124.jpg' },
          { id: 3,
            title: 'Teaching',
            file: 'teacher.jpg' },
          { id: 4,
            title: 'Working with others',
            file: 'people-in-meeting.jpg' }
        ]
      end
    end
  end
end
