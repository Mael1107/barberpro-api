class Api::V1::ServicesController < ApplicationController
  before_action :optional_authorize, only: [:index, :show]
  before_action :authorize_request, except: [:index, :show]
  before_action :set_service, except: [:index, :create]
  before_action -> { authorize_role!(:admin) }, only: [:create, :update, :destroy]

  def index
    services = if params[:include_inactive] == "true" && @current_user&.admin?
      Service.all
    else
      Service.active
    end
    render json: services
  end

  def show
    render json: @service
  end

  def create
    service = Service.new(service_params)

    if service.save
      render json: service, status: :created
    else
      render json: service.errors, status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      render json: @service
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @service.update(active: false)
    head :no_content
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.permit(:name, :price, :duration_minutes, :active)
  end
end
