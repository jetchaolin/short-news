class Article < ApplicationRecord
  validates :title, :published_at, :body, presence: true
end
