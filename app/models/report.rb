# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Report < ActiveRecord::Base
	attr_accessible :content
	validates :user_id , presence: true
	validates :content , presence: true
	belongs_to :user
	default_scope order: 'reports.created_at DESC' 
end
