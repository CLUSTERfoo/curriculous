# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
#MemoRabble::Application.config.secret_key_base = '111d9d43a402efb2cf3e64597c570c3e98b8bb7391a83710722fab1f7f3c3284b0ce4aa15b78db3ab77edb3ff7eb7debd2a28ed39f5251418fe98e3f6e419630'
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    File.read(token_file).chomp
  else
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

MemoRabble::Application.config.secret_key_base = secure_token
