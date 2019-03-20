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
  belongs_to :receiver_group

  # 类方法
  class << self
    def add_domain params
      response = Response.rescue do |res|
        url = params[:url]
        receiver_group_id = params[:receiver_group_id] || nil
        self.create!(url: url, receiver_group_id: receiver_group_id)
      end
      response
    end

    # 查询接口
    def search_domains params
      domains = []
      response = Response.rescue do |res|
        page = params[:page] || 1
        per = params[:per] || 10
        domains = search_by_params(params).page(page).per(per)
      end
      [response, domains]
    end

    def refresh_domain params
      response = Response.rescue do |res|
        domain = Domain.find_by(id: params[:id])
        domain.update_expire_days
      end
      response
    end

    def delete_domains params
      response = Response.rescue do |res|
        domains = Domain.find(params[:ids])
        domains.each do |item|
          item.destroy
        end
      end
      response
    end

    def check_domains
      domains = Domain.includes(:receiver_group).all
      domains.each do |item|
        remained_days = expire_days(get_expire_date item.url)

      end
    end

  end


  # 实例方法
  def update_expire_days
    expire_date = get_expire_date self.url
    remained_days = expire_days expire_date
    self.update!(remained_days: remained_days, expire_date: expire_date)
  end

end
