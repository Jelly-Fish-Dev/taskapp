class Task < ApplicationRecord
  belongs_to :account
  belongs_to :project
  has_many :account_projects
  enum status: { todo: 'To Do', in_progress: 'In Progress', done: 'Done' }

end
