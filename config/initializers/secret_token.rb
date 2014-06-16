# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Blog::Application.config.secret_key_base = '512e18984b41b16144f6a3bc6ce6eabbd004db81630bdb27507cab42295fd01b7b6617b7b3da2dc57b6ff9f8e4b118b9dd64368cdc15090b08bfe68b5e14f5a9'
