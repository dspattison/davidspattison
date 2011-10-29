require "#{Rails.root}/lib/crypt/gib/main"

module Spaste::PastesHelper
  
  def new_key_set
    crypt = Crypt::Gib::Main.new
    crypt.new_key_set
  end
  
  def encrypt_params params, public_key
    crypt = Crypt::Gib::Main.new
    
    params[:body] = crypt.encrypt params[:body], public_key
    params[:public_key] = public_key.to_s
    params[:version] = '1.0.0'
    params
  end
  
  def decrypt_paste paste, secret_key
    crypt = Crypt::Gib::Main.new
    paste.body = crypt.decrypt paste.body, secret_key 
    paste
  end
  
end
