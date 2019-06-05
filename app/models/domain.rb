# == Schema Information
#
# Table name: domains
#
#  id                             :integer          not null, primary key
#  url                            :string
#  remained_days                  :integer
#  receiver_group_id              :integer
#  expire_date                    :datetime
#  alert_level                    :integer
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


  module AlertLevel
    NORMAL = 90
    LOW = 30
    HIGH = 15
    VERYHIGH = 7
    CRITICAL = 1
  end

  # 类方法
  class << self
    def add_domain params
      domains = []
      count = 0
      response = Response.rescue do |res|
        url = params[:url]
        receiver_group_id = params[:receiver_group_id] || nil
        self.create!(url: url, receiver_group_id: receiver_group_id)
        domains, count = all_domains params
      end
      [response, domains, count]
    end

    # 查询接口
    def search_domains params
      domains = []
      count = 0
      response = Response.rescue do |res|
        page = params[:page] || 1
        per = params[:per] || 5
        domains = search_by_params(params).page(page).per(per)
        count = Domain.all.count
      end
      [response, domains, count]
    end

    def delete_domains params
      domains = []
      count = 0
      response = Response.rescue do |res|
        domains = Domain.find(params[:ids])
        domains.each do |item|
          item.destroy
        end
        domains, count = all_domains params
      end
      [response, domains, count]
    end

    def check_domains
      Domain.includes(:receiver_group).find_each do |item|
        item.update_expire_days
      end
    end

    def refresh params
      domains = []
      count = 0
      response = Response.rescue do |res|
        check_domains
        domains, count = all_domains params
      end
      [response, domains, count]
    end


    def all_domains params
      page = params[:page] || 1
      per = params[:per] || 10
      domains = Domain.all.page(page).per(per)
      count = Domain.count
      [domains, count]
    end

  end


  # 实例方法
  def update_expire_days
    self.expire_date = get_expire_date self.url
    self.remained_days = expire_days expire_date
    self.alert_level = set_alert_level remained_days
    puts self.alert_level_change
    if self.alert_level_changed? and self.receiver_group&.receivers.present?
      # 非持久化异步，待执行任务会被丢弃
      # UserMailer.notice_email(self).deliver_later
      UserMailer.notice_email(self).deliver_now
    end
    self.save!
  end

  def set_alert_level(remained_days)
    alert_level = nil
    case remained_days
      when 31..90
        alert_level = AlertLevel::NORMAL
      when 16..30
        alert_level = AlertLevel::LOW
      when 8..15
        alert_level = AlertLevel::HIGH
      when 2..7
        alert_level = AlertLevel::VERYHIGH
      when 1
        alert_level = AlertLevel::CRITICAL
    end
  end

end
