class Spirit < ApplicationRecord
  has_many :orders
  has_many :spirit_aromas
  has_many :aromas, through: :spirit_aromas
  has_many :families, through: :aromas
  has_many :experiences
  has_many :users, through: :experiences
end
