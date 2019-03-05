class ReceiverMap < ApplicationRecord
  belongs_to :receiver
  belongs_to :receiver_group
end
