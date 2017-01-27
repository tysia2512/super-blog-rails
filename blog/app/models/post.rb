class Post < ApplicationRecord
  validates_presence_of :title, :content
  validates_length_of :title, :minimum => 5
end
