class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true

  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }

  scope :title_search, ->(title) { where("title LIKE ?", "%" + sanitize_sql_like(title) + "%") }
  scope :status_search, ->(status) { where(status: status) }
end
