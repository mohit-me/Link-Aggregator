class Vote < ActiveRecord::Base
  attr_accessible :link_id, :user_id

  belongs_to :link, :counter_cache => true

end
