class ReceiverGroup < ApplicationRecord
  has_many :receiver_maps
  has_many :receivers, through: :receiver_maps
end
