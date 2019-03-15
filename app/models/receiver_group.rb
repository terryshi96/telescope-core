# == Schema Information
#
# Table name: receiver_groups
#
#  id                             :integer          not null, primary key
#  name                           :string
#  active                         :boolean
#  deleted_at                     :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null

class ReceiverGroup < ApplicationRecord
  include BaseModelConcern
  acts_as_paranoid
  validates :name, presence: true, uniqueness: true

  has_many :receiver_maps, dependent: :destroy
  has_many :receivers, through: :receiver_maps
  has_many :domains
  class << self
    def add_group params
      response = Response.rescue do |res|
        name = params[:name]
        self.create!(name: name)
      end
      response
    end

    def update_group params

    end

    def delete_groups params

    end

    def search_groups params
      groups = []
      response = Response.rescue do |res|
        page = params[:page] || 1
        per = params[:per] || 10
        groups = search_by_params(params).page(page).per(per)
      end
      [response, groups]
    end

  end


end
