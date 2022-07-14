class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
  enum priority: { 高: 3, 中: 2, 低: 1 }

  scope :title_search, ->(title) { where("title LIKE ?", "%" + sanitize_sql_like(title) + "%") }
  scope :status_search, ->(status) { where(status: status) }
end
