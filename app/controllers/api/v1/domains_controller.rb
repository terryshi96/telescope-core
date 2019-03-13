class Api::V1::DomainsController < ApplicationController
  def create
    @response = Domain.add_domain params
  end

  def update
    @response = Domain.update_domains params
  end

  def delete
    @response = Domain.delete_domains params
  end

  def get_domains
    @response, @domains = Domain.search_domains params
  end
end
