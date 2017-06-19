class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable
  has_many :pictures
  mount_uploader :avatar, AvatarUploader #deviseの設定配下に追記

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

 def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      user.save(validate: false)
    end
    user
  end

  def twitter
    # You need to implement the method below in your model
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

end
