class Project < ApplicationRecord
  belongs_to :user
  has_many :project_images, -> { order(:position) }, dependent: :destroy
  has_many :project_links, -> { order(:position) }, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true
  validates :description, presence: true
  validates :author_name, presence: true

  scope :recent, -> { order(created_at: :desc) }

  accepts_nested_attributes_for :project_links, allow_destroy: true, reject_if: :all_blank
end
