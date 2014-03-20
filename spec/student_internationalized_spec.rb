require 'rspec'
require_relative '../app/models/student'


describe Student do

  it "should have a name method that returns their fullname" do
    student = Student.new
    student.first_name = "John"
    student.last_name = 'Doe'
    student.name.should == "John Doe"
  end

  it "should contain correct sample data" do
    Student.where("first_name = ? AND last_name = ?", "Karim", "Bishay").count.should be >= 1
  end

end
