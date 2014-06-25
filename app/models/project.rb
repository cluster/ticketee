class Project < ActiveRecord::Base
  validates :name, presence: true
  #delete_all doesn't call the callbacks on each ticket, use :destroy instead if needed
  has_many :tickets, dependent: :delete_all
end
