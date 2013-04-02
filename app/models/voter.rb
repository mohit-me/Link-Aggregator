class Voter < ActiveRecord::Base
  attr_accessible :upvoted_by, :upvoted_link
end
