class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :images,
    content_type: %w[image/png image/jpeg],
    size: { less_than: 5.megabytes }
end
