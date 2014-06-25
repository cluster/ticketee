class Ticket < ActiveRecord::Base
  belongs_to :project
  validates :title, :description, presence: true
  validates :description, length: {minimum: 10}
end