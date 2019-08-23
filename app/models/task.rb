class Task < ApplicationRecord
    validates :creater, {presence: true}
    validates :content, {presence: true}
    validates :doer, {presence: true} 
end
