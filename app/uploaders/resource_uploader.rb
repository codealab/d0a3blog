# encoding: utf-8
class ResourceUploader < CarrierWave::Uploader::Base

  if RbConfig::CONFIG["target_os"] =~ /mswin|mingw|cygwin/i
    include CarrierWave::MiniMagick
  else
    include CarrierWave::RMagick
  end

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # def default_url
  #   "/assets/" + [version_name, "default.png"].compact.join('_')
  # end

  version :large do
    # resize_to_limit(900, 600)
    process :crop_resource(900,600)
  end

  version :medium do
    # resize_to_limit(600, 400)
    process :crop_resource(600,400)
  end

  version :thumb do
    process :crop_resource(300,200)
    # resize_to_fill(300, 200)
  end

  def crop_resource(width,height)
    if model.crop_x.present?
      resize_to_limit(width,height)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
      end
    end
  end

end