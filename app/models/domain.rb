# == Schema Information
#
# Table name: domains
#
#  id                             :integer          not null, primary key
#  url                            :string
#  remained_days                  :integer
#  receiver_group_id              :integer
#  expire_date                    :datetime
#  deleted_at                     :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null

class Domain < ApplicationRecord
  include BaseModelConcern
  # 启用软删除
  acts_as_paranoid

  # 数据验证
  validates :url, presence: true, uniqueness: true

  # 回调
  after_create :update_expire_days

  # 类方法
  class << self
    def add_domain params
      response = Response.rescue do |res|
        # Returns values that were assigned to the given keys
        url = params[:url]
        receiver_group_id = params[:receiver_group_id] || nil
        self.create!(url: url, receiver_group_id: receiver_group_id)
      end
      response
    end

    def search_domains params
      domains = []
      response = Response.rescue do |res|
        page = params[:page] || 1
        per = params[:per] || 10
        domains = search_by_params(params).page(page).per(per)
      end
      [response, domains]
    end

    def update_domains params

    end

    def delete_domains params

    end

  end


  # 实例方法
  def update_expire_days
    expire_date = get_expire_date self.url
    remained_days = expire_days expire_date
    self.update!(remained_days: remained_days, expire_date: expire_date)
  end

end
