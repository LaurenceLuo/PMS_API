class Room < ApplicationRecord
    has_many :guests, dependent: :destroy
    validates_presence_of :title, :created_by
end
