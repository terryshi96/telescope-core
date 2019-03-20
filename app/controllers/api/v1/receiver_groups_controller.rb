class Api::V1::ReceiverGroupsController < ApplicationController
  def create
    @response = ReceiverGroup.add_group params
  end

  def update_group
    @response = ReceiverGroup.update_group params
  end

  def delete
    @response = ReceiverGroup.delete_groups params
  end

  def get_groups
    @response, @groups = ReceiverGroup.search_groups params
  end

  def join_group
    @response = ReceiverGroup.join_group params
  end
end
