module WorkForwardNola
  module Views
    # logic for layout.mustache
    class Layout < Mustache
      def title
        @title || 'OMG TITLE'
      end
    end
  end
end
