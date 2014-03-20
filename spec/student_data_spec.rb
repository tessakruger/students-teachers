require 'rspec'
require_relative '../config'

describe Student, "Sample data" do

  it "should contain one of the students from the CSV" do
    Student.where("first_name = ? AND last_name = ?", "Ian", "Smith").count.should be >= 1
  end

end
