class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :entry
  belongs_to :comment
end
