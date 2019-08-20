class Photo < ApplicationRecord
  belongs_to :room

  has_attached_file :image, styles: {  large: "1000x1000>", medium: "750x750>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
