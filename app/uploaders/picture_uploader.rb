class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  limit = [Settings.uploader.picture.width, Settings.uploader.picture.height]

  process resize_to_limit: limit
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
