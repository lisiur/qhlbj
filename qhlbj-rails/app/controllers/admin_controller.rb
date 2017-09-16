class AdminController < ApplicationController
	before_action :set_admin, only: [:login, :modify_password]

  def test
    if $TOKEN and $TOKEN == params[:token]
      render json: { login: true }
    else
      render json: { login: false }
    end
  end

  def modify_password
  end

  def login
    if @admin
      $TOKEN = Digest::SHA1.hexdigest(Time.new.to_s)
      render json: { login: true, token: $TOKEN }
    else
      render json: { login: false }
    end
  end

  def logout
    if $TOKEN == params[:token]
      $TOKEN = nil
      render json: { login: false }
    else
      render json: { login: true, message: 'wrong token'}
    end
  end

	private
    def set_admin
			@admin = Admin.where({name: params['username'], password_digest: params['password']}).take
		end

		def admin_params
			params.require(:admin).permit(:username, :password, :token)
		end
end
