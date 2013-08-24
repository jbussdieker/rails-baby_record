class Event < ActiveRecord::Base
  attr_accessible :bottle_amount, :dirty_diaper, :left_breast, :right_breast, :wet_diaper
end
