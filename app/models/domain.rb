class Domain < ApplicationRecord
  include BaseModelConcern

  def update_expire_days
    expire_date = get_expire_date self.url
    remained_days = expire_days expire_date
  end
end
