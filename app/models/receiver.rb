class Receiver < ApplicationRecord
  has_many :receiver_maps
  has_many :receiver_groups, through: :receiver_maps
end
