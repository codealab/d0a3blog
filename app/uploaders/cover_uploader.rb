# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base

   include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/" + [version_name, "default.png"].compact.join('_')
  end

  version :large do
    resize_to_limit(752, 500)
  end

end