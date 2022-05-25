class User < ApplicationRecord
  has_many :party_users
  has_many :viewing_parties, through: :party_users

  validates :name, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def is_host?(party_id)
    PartyUser.find_by(user_id: id, viewing_party_id: party_id).host
  end

end
