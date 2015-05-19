describe Student, 'Sample data' do
  before :each do
    StudentsImporter.new.import
  end

  it 'should contain one of the students from the CSV' do
    expect(Student.where('first_name = ? AND last_name = ?', 'Ian', 'Smith').exists?).to be(true)
  end
end
