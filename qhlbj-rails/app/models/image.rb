class Image < ApplicationRecord
  mount_uploader :name, ImageUploader
end
