class Link < ActiveRecord::Base
  attr_accessible :content, :domain, :downVotes, :imgUrl, :name, :upVotes, :submitted_by, :votes_count

	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'

	has_many :votes

	def get_host_without_www(url)
	  url = "http://#{url}" if URI.parse(url).scheme.nil?
	  host = URI.parse(url).host.downcase
	  host.start_with?('www.') ? host[4..-1] : host
	end

  def format_num_votes
  	url =name
  	#if self.imgUrl == ""
			self.upVotes =0
  		self.downVotes =0
  		self.votes_count=0
  		domain = get_host_without_www(url)
			self.domain=domain
			doc = Nokogiri::HTML(open(url))
			title = ""
			imgLink = ""
			if domain == 'theverge.com'
				title = doc.at_css("title").text
				imgLink = doc.at_css('.story-image img')['src']
			elsif domain =='engadget.com'
				title = doc.at_css("title").text
				imgLink = doc.at_css('.post-body img')['src']
			else
				title = doc.at_css("title").text
				imgLink = doc.at_css('img')['src']
			end
			self.content=title
			self.imgUrl=imgLink
		#end
		#self.submitted_by = current_user.email
  	
  end

  def increase_vote_count
  	self.upVotes||=0
  	self.upVotes=self.upVotes+1
  end

  before_create :format_num_votes

  before_save :increase_vote_count

  validates_uniqueness_of :name,:message => "URL has already been submitted, Maybe you would want to upvote it?"
  validates :name, :presence => true, :url => true

end

class UrlValidator < ActiveModel::EachValidator
 	require 'open-uri'
  def validate_each(record, attribute, value)
    valid = begin
      URI.parse(value).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
    unless valid
      record.errors[attribute] << (options[:message] || "is an invalid URL")
    end
  end
end