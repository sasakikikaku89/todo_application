class Task < ApplicationRecord
    
    validates :content, {presence: true}
    validates :deadline, {presence: true}
    validates :doer, {presence: true} 
end
