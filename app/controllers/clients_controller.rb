class ClientsController < ApplicationController
  def all
    result = ::UseCases::Client::GetAll.new(params.merge(user: current_user)).call
    render_result result
  end

  def create
    result = ::UseCases::Client::CreateClient.new(permitted_params.merge(user: current_user)).call
    render_result result
  end

  def update
    result = ::UseCases::Client::UpdateClient.new(permitted_params.merge(user: current_user)).call
    render_result result
  end

  def delete
    result = ::UseCases::Client::DeleteClient.new(params.merge(user: current_user)).call
    render_result result
  end

  private

  def permitted_params
    params.require(:client).permit(:id, :name, :email, :phone, address: %i[street number neighborhood city uf])
  end
end
