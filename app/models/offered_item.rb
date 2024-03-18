class OfferedItem < ApplicationRecord
  belongs_to :offer
  belongs_to :item
end
