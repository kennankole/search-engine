class ArticleQueryLog < ApplicationRecord
  validates :query, presence: true
  validates :ip, presence: true
end
