class Task < ApplicationRecord
    validates :content, {presence: true}
    validates :deadline, {presence: true}
    validates :doer, {presence: true} 

    belongs_to :user
end
