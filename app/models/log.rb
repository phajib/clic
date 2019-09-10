class Log < ActiveRecord::Base
    belongs_to :users

    include Slugifiable::InstanceMethods
    extend Slugifiable::ClassMethods
end
