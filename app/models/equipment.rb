class Equipment < ActiveRecord::Base
    belongs_to :users
    has_many :logs through: :users
end
