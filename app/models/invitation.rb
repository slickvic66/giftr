class Invitation < ActiveRecord::Base
  attr_accessible :exchange_id, :invited_email, :token, :accepted, 
  :sender_id

  has_one  :notification,
           :foreign_key => :associated_id,
           :class_name => "Notification"

  belongs_to :exchange, :inverse_of => :invitations

  has_one :recipient,
          :through => :notifications,
          :class_name => "User"

  # Need sender id to later autofill any emails a user has sent to before via ajax

  belongs_to :sender, 
             :foreign_key => :sender_id, 
             :class_name => "User"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :invited_email, presence: true, uniqueness: { :scope => :exchange_id }, format: { with: VALID_EMAIL_REGEX }
  validates :exchange, presence: true

  before_create :generate_token 

  def is_registered?
    return true if User.find_by_email(invited_email)
  end

  private

  def generate_token
    self.token = Digest::MD5.hexdigest(self.invited_email)
  end

end
