class Image < ApplicationRecord
	belongs_to :topic

	has_attached_file :image, styles: { medium: "1100x1100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
