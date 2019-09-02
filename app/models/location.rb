class Location < ActiveRecord::Base
    belongs_to :logs
    has_many :logs, through: :users
end
