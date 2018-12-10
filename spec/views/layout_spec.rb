require 'spec_helper'
require './views/layout'

describe WorkForwardNola::Views::Layout do
  # TODO: auto-generated
  describe '#title' do
    it 'works' do
      layout = WorkForwardNola::Views::Layout.new
      result = layout.title
      expect(result).not_to be_nil
    end
  end
end
