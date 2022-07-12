class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }

  enum admin: { 有り: true, 無し: false }

  before_validation { email.downcase! }
  before_destroy :least_one_admin
  before_update :least_one_admin

  private

  def least_one_admin
    if User.where(admin: :有り).count == 1 && self.admin_before_type_cast
      errors.add :base, "少なくとも1人は管理者ユーザーが必要です！"
      throw :abort
    end
  end
end
