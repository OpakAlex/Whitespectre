class GroupEvent < ActiveRecord::Base
  enum status: { draft: 0, published: 1, archived: 2 }

  validates :title, :start_date, presence: true
  validates :end_date, :longitude, :latitude, :body, presence: true, if: [:published?]

  scope :visible, -> { where.not(status: 2) }
end
