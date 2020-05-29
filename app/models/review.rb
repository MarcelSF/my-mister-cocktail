class Review < ApplicationRecord
  RATINGS = [0,1,2,3,4,5]
  belongs_to :cocktail
  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: RATINGS }
end
