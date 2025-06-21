class ProjectLink < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :link_type, presence: true

  LINK_TYPES = {
    "github" => { icon: "🐙", color: "text-gray-300", border: "border-gray-500" },
    "youtube" => { icon: "🎥", color: "text-red-400", border: "border-red-500" },
    "demo" => { icon: "🚀", color: "text-blue-400", border: "border-blue-500" },
    "documentation" => { icon: "📚", color: "text-yellow-400", border: "border-yellow-500" },
    "figma" => { icon: "🎨", color: "text-purple-400", border: "border-purple-500" },
    "linkedin" => { icon: "💼", color: "text-blue-300", border: "border-blue-400" },
    "portfolio" => { icon: "👤", color: "text-green-400", border: "border-green-500" },
    "custom" => { icon: "🔗", color: "text-gray-400", border: "border-gray-600" }
  }.freeze

  scope :ordered, -> { order(:position) }

  def link_config
    LINK_TYPES[link_type] || LINK_TYPES["custom"]
  end

  def display_icon
    icon.presence || link_config[:icon]
  end
end
