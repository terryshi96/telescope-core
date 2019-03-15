class Api::V1::ReceiversController < ApplicationController
  def create
    @response = Receiver.add_receiver params
  end

  def update_receiver
    @response = Receiver.update_receiver params
  end

  def delete
    @response = Receiver.delete_receivers params
  end

  def get_receivers
    @response, @receivers = Receiver.search_receivers params
  end

end
