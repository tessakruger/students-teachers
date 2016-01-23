require 'faker'

class TeachersImporter

  def create_teachers
    9.times do
      Teacher.create!(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.email,
                      phone: Faker::PhoneNumber.phone_number
                      )
    end
  end
end
