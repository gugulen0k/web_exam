class ProjectImage < ApplicationRecord
  belongs_to :project
  has_one_attached :image

  validates :image, presence: true

  scope :ordered, -> { order(:position) }
end
