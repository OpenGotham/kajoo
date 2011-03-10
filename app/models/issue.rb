class Issue < ActiveRecord::Base
  has_many :reports
  has_many :comments
  
  geocoded_by :address_with_city_and_state, :latitude  => :lat, :longitude => :lon
  
  reverse_geocoded_by :lat, :lon
  
  #validates_presence_of :reports
  
  def self.find_similar(report)
    similar = self.near([report.lat, report.lon], 1)
  end

  after_validation :reverse_geocode
  has_many :votes, :class_name => 'IssueVote'
  has_many :supporters, :through => :votes, :class_name => 'User', :uniq => true
  
  def address_with_city_and_state
    return "#{address}, #{SITE['city_name']}, #{SITE['state_name']}, #{SITE['country_name']}"
  end
  
  def location_name
    return 'Downtown Austin'
  end
  
  def add_vote_for_user(user)
    
    unless(user.votes_remaining > 0)
      throw Exception.new('Not enough votes')
    end
    
    @vote = votes.create({:user => user})
    
    user.add_points(5)
  end
  
end

# == Schema Information
#
# Table name: issues
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  lat         :float
#  lon         :float
#  radius      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  report_id   :integer
#

