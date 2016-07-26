module WorkForwardNola
  class Career < Sequel::Model
    many_to_many :traits
  end
end