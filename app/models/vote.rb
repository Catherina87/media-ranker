class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, presence: true
  validates :user_id, uniqueness: { scope: :work_id, message: "has already voted for this work" }
end
