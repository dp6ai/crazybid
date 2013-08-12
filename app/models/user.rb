class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [ :user_name ]
  # before_validation :set_initial_credits

  validates_numericality_of :credit, greater_than: -1
  has_many :bids

  before_validation(on: :create) do |user|
    user.credit = 0
  end

  def set_initial_credits
    self.credit=0
  end
  
end
