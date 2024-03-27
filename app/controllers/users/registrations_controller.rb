# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
    if resource.persisted?
      description = BookingPermissionRequest.build_description_from_params(params)
      Rails.logger.info params
      Rails.logger.info description
      BookingPermissionRequest.create(user: resource, status: 'pending', permission_type: 'rehearsal', description: description)
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :is_krk_registered,
      :password,
      :password_confirmation,
      :phone_number,
      :billing_address,
      :website,
      :bio,
      :permission_request_type,
      :dance_practice_description,
      :studio_usage,
      :preferred_language,
      :is_workshop_newsletter_registered,
      :is_course_newsletter_registered,
      :agree_to_terms,
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
