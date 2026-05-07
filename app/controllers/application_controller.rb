class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JwtService.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded["user_id"])
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  def authorize_role!(*allowed_roles)
    unless allowed_roles.map(&:to_s).include?(@current_user&.role)
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end
end
