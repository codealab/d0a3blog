CarrierWave.configure do |config|

  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      :region                => 'us-west-2'
    }
  else
    config.storage = :file
  end
 
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end
 
  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku 
  config.fog_directory    = ENV['S3_BUCKET_NAME']
 
end