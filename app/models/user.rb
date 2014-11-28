class User < ActiveRecord::Base
  attr_accessible :email, :name ,:avatar
  has_attached_file :avatar ,:styles => {:mini => '48x48>', :small => '110x110>', :product => '220x220>', :large => '600x600>' ,:angled=> {:geometry =>'600x600',:processors => [:rotator]} }
end
