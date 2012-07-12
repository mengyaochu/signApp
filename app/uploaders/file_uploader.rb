# encoding: utf-8
require 'carrierwave/processing/mime_types'

class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes
  include CarrierWave::MiniMagick

  process :set_content_type

  #storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  if Rails.env.eql? 'production'
      storage :fog
     else
      storage :file
    end



  #def paperclip_path
  #    "assets/products/:id/:style/:basename.:extension"
  # end

 # File Versions
   version :large do
       process :resize_to_fit => [500,400]
    end

    version :medium do
      process :resize_to_fit => [350,250]
    end

    version :small do
      process :resize_to_fit => [250,150]
    end

    version :thumb do
    #  process :resize_to_fill => [100,75, :north]
      process :resize_to_fill => [100,75]
    end


   version :with_mirror do
     process :resize_to_fill => [150, 150]
     #process :add_mirror_effect => 0.2
   end





 # S3 Directory
  #----------------------------------------------------------------------------
  #def store_dir1
  #  "#{model.class.to_s.pluralize.underscore}/#{mounted_as.to_s.pluralize}/#{model.id}/#{version_name || :original}"
  #end

  # Default URL
  #----------------------------------------------------------------------------
  def default_url
    "/images/default_#{version_name || :original}_photo.jpg"
  end

  # File Extensions Allowed
  #----------------------------------------------------------------------------
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # URLs Filename
  #----------------------------------------------------------------------------
  def full_filename (for_file = model.photo.file)
    "#{for_file}"
  end

  # Database Filename
  #----------------------------------------------------------------------------
  def filename
    "#{original_filename}" if original_filename.present?
  end

 private

  def add_mirror_effect(mirror_length)
      manipulate! do |img|
      mirror_rows = img.rows * mirror_length

      gradient = Magick::GradientFill.new(0, 0, mirror_rows, 0, "#888", "#000")
      gradient = Magick::Image.new(img.columns, mirror_rows, gradient)
      gradient.matte = false

      flipped = img.flip
      flipped.matte = true
      flipped.composite!(gradient, 0, 0, Magick::CopyOpacityCompositeOp)

      new_frame = Magick::Image.new(img.columns, img.rows + mirror_rows)
      new_frame.composite!(img, 0, 0, Magick::OverCompositeOp)
      new_frame.composite!(flipped, 0, img.rows, Magick::OverCompositeOp)
    end
  end


end
