module WorkForwardNola
  module Views
    # logic for showing woofound images
    class Woofound < Layout
      attr_reader :title

      def images
        [
          { trait: 'Technical',
            title: 'Working with technology',
            file: 'computer-user.jpg' },
          { trait: 'Outdoor work',
            title: 'Working outside',
            file: 'Gardening-LB0507-1124.jpg' },
          { trait: 'Organized',
            title: 'Teaching',
            file: 'teacher.jpg' },
          { trait: 'Teamwork',
            title: 'Working with others',
            file: 'people-in-meeting.jpg' }
        ]
      end
    end
  end
end
