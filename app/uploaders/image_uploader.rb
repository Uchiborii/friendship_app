class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  version :thumb do
  storage :file
  process resize_to_limit: [50, 50]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def resize_to_limit(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}>"
      img = yield(img) if block_given?
      img
    end
  end
end
