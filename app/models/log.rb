class Log < ActiveRecord::Base
    belongs_to :user

    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods
end
