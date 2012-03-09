class Card < ActiveRecord::Base
  belongs_to :deck
  
  acts_as_list :scope => :deck
  
  validate :content, :presence => true
end
