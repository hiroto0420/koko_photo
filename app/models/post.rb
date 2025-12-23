class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validate :images_count_within_limit

  validates :images,
    content_type: %w[image/png image/jpeg],
    size: { less_than: 5.megabytes }

  private

  def images_count_within_limit
    if images.attached? && images.count > 10
      errors.add(:images, "は10枚までアップロードできます")
    end
  end
end
