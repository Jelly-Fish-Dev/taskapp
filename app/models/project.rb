class Project < ApplicationRecord
  belongs_to :account
  has_many :account_projects
  has_many :tasks
end
