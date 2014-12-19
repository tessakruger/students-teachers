class StudentsImporter

  def initialize(filename=File.dirname(__FILE__) + "/../db/data/students.csv")
    @filename = filename
  end

  def import
    field_names = ['first_name', 'last_name', 'gender', 'birthday', 'email', 'phone']

    print "Importing students from #{@filename}: "
    failure_count = 0

    Student.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          student = Student.create!(attribute_hash)
          print "."; STDOUT.flush
        rescue ActiveRecord::UnknownAttributeError
          print "!"; STDOUT.flush
          failure_count += 1
        end
      end
    end
    failures = "(failed to create #{failure_count} student records)" if failure_count > 0
    puts "\nDONE #{failures}\n\n"
  end

end
