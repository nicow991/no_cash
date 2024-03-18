class Review < ApplicationRecord
  belongs_to :user
  belongs_to :deal
  belongs_to :reviewer
end
