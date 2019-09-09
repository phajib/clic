require_all 'app'

class User < ActiveRecord::Base
    has_many :logs
    has_secure_password
end