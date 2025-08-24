class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    redirect_to root_path, notice: "退会しました。"
  end
end
