class AlarmRecord < ApplicationRecord
    include BaseModelConcern
    acts_as_paranoid
    validates :subject, :content, presence: true
    has_many :steps

    
    module Status
        NEW = 'new'
        IN_PROCESS = 'in_process'
        FINISH = 'finish'
        HANG = 'hang'
    end
    
end
