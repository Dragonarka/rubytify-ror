class Genre < ApplicationRecord
    validates_presence_of :name
    has_and_belongs_to_many :artists

end
