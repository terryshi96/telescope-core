class Receiver < ApplicationRecord
  include BaseModelConcern
  acts_as_paranoid
  validates :name, presence: true, uniqueness: true
  has_many :receiver_maps, dependent: :destroy
  has_many :receiver_groups, through: :receiver_maps

  class << self
    def add_receiver params
      response = Response.rescue do |res|
        name = params[:name]
        self.create!(name: name)
      end
      response
    end

    def update_receiver params

    end

    def delete_receivers params

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
