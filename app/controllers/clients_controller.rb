class ClientsController < ApplicationController
  def all
    result = ::UseCases::Client::GetAll.new(params.merge(user: current_user))
    render_result result
  end

  def create
    # code here
  end

  def update
    # code here
  end

  def delete
    # code here
  end
end
