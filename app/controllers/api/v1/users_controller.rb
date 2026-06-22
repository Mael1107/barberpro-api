class Api::V1::UsersController < ApplicationController
  before_action :authorize_request
  before_action -> { authorize_role!(:admin) }
  before_action :set_user, only: [:promote_to_barber]

  def index
    users = User.all
    users = users.where(role: params[:role]) if params[:role].present?
    render json: users.map(&:as_auth_json)
  end

  def promote_to_barber
    return render json: { error: "Cannot promote yourself" }, status: :forbidden if @user == @current_user
    return render json: { error: "User is already a barber" }, status: :unprocessable_entity if @user.barber?

    ActiveRecord::Base.transaction do
      @user.barber!
      @user.create_barber_profile!(profile_params)
    end

    render json: @user.as_auth_json.merge(barber_profile: @user.barber_profile)
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def profile_params
    params.permit(:bio, :photo_url, :instagram)
  end
end