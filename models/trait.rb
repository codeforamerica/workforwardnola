module WorkForwardNola
  class Trait < Sequel::Model
    many_to_many :careers
  end
end
