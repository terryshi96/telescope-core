class Step < ApplicationRecord
    include BaseModelConcern
    acts_as_paranoid
    belongs_to :alarm_record
end
