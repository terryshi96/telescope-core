class Api::V1::DomainsController < ApplicationController
  def create
    @response, @domains, @count = Domain.add_domain params
  end

  def delete
    @response, @domains, @count = Domain.delete_domains params
  end

  def get_domains
    @response, @domains, @count = Domain.search_domains params
  end

  def refresh
    @respone, @domains, @count = Domain.refresh params
  end
end
