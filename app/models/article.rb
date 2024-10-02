class Article < ApplicationRecord
  belongs_to :category
  validates :title, :published_at, :body, presence: true
end
