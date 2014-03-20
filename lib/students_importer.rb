class StudentsImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/students.csv")
    @filename = filename
  end

  def import
    field_names = ['first_name', 'last_name', 'gender', 'birthday', 'email', 'phone']

    print "Importing students from #{@filename}: "
    Student.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        student = Student.create!(attribute_hash)
        print "."; STDOUT.flush
      end
    end
    puts "\nDONE"
  end

end
