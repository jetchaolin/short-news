class Article < ApplicationRecord
  belongs_to :category
  validates :title, :published_at, :body, presence: true

  def self.search(search)
    where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%")
    # where("title LIKE :search OR body LIKE :search OR category LIKE :search", search: "%#{search}%")
  end
end
