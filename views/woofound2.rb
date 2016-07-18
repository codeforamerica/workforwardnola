module WorkForwardNola
  module Views
    # logic for showing woofound images
    class Woofound2 < Layout
      attr_reader :title

      def images
        [
          { id: 1,
            title: 'Teaching',
            file: 'teacher.jpg' },
          { id: 2,
            title: 'Working with others',
            file: 'people-in-meeting.jpg' }
        ]
      end
    end
  end
end
