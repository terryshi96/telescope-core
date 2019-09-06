# == Schema Information
#
# Table name: receiver_groups
#
#  id                             :integer          not null, primary key
#  name                           :string
#  email                           :string
#  phone                          :string
#  active                         :boolean
#  deleted_at                     :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  报警接收人和用户区分开来，用户是真正处理报警的人
class Receiver < ApplicationRecord
  include BaseModelConcern
  acts_as_paranoid
  validates :name, presence: true, uniqueness: true

  has_many :receiver_maps, dependent: :destroy
  has_many :receiver_groups, through: :receiver_maps

  class << self
    def add_receiver params
      response = Response.rescue do |res|
        name, mail, phone = params.values_at(:name, :mail, :phone)
        self.create!(name: name, mail: mail, phone: phone)
      end
    end

    def update_receiver params
      response = Response.rescue do |res|
        id, name, mail, phone = params.values_at(:id, :name, :mail, :phone)
        receiver = Receiver.find id
        receiver.update!(name: name, mail: mail, phone: phone)
      end
    end

    def delete_receivers params
      response = Response.rescue do |res|
        receivers = Receiver.find(params[:ids])
        receivers.each do |item|
          item.destroy
        end
      end
    end

    def search_receivers params
      receivers = []
      response = Response.rescue do |res|
        page = params[:page] || 1
        per = params[:per] || 10
        receivers = search_by_params(params).page(page).per(per)
      end
      [response, receivers]
    end

  end

end
