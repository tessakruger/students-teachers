class Student < ActiveRecord::Base

  belongs_to :teacher

  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :age, numericality: { greater_than: 3 }

  def name
  	"#{self.first_name} #{self.last_name}"
  end

  def age
  	now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end
  
end