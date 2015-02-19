Week 3 Day 4 - Assignment
===========================

# ActiveRecord Students & Teachers

## Introduction

You probably remember how to associate tables in a database using foreign keys. This assignment will build on that knowledge and extend it into the realm of the ActiveRecord ORM. We'll also use database migrations to modify our database over time.


### Topics

* SQLite database
* Database Migrations
* One to many associations
* Many to many associations
* Unit Testing models with RSpec
* Rake commands

### Getting Started

1. Fork this repository.
2. Clone your fork of this repository into your working directory.
3. Install the necessary dependencies using Bundler: `bundle`
4. Create your database: `rake db:create`

## What are Migrations?

Migrations are ActiveRecord's way for allowing us to modify the database structure using ruby code. 


Instead of creating a table manually using a SQL query like this...

```SQL
CREATE TABLE employees
(
id INT NOT NULL,
first_name varchar(255),
last_name varchar(255),
address varchar(255),
PRIMARY KEY (id)
);
```

...we can use an ActiveRecord migration class to define the table:

```ruby
class CreateEmployees < ActiveRecord::Migration
    # Use the up method to define a change in the database structure.
    def up
        create_table :employees do |t|
            t.string :first_name
            t.string :last_name
            t.string :address
        end
    end
    
    # Write the command that will revert the change made in the up method.
    def down
        drop_table :employees
    end
end
```

_TIP:_  Do not confuse ActiveRecord migrations with ActiveRecord objects. ActiveRecord migrations manage the structure of the tables: `add_column :students, :address, :string`. ActiveRecord objects manage the data within tables: `Student.find(1)`  or `@student.where(firstname: "Anne")`.

Read about migrations here (to understand them, don't worry about memorizing the different approaches, etc): <http://guides.rubyonrails.org/migrations.html>

## Objectives

### 1. Setup Students table

There is a Student model already. But the database does not yet have the `students` table. In fact you don't even have a development database to work against yet.

We need to create an empty database and then update the schema (structure of the database) to include a `students` table. We will use migrations for this.

#### Step 1 - Create DB

Run this rake command to create the database file: `rake db:create`

How does that work? What does it do? Hint: take a look at the `Rakefile`

#### Step 2 - Create `students` table

Modify the CreateStudents migration in `db/migrate/20140319144238_create_students.rb` and implement the `up` and `down` methods. To find out what columns we need in the students table, look at the student data in `db/data/students.csv`.

Once you implement it, run `rake db:migrate` to run the migration against the database.

#### Step 3 - Make sure the tests pass

We wrote a test case that checks if you created the students table: `spec/migrate_create_table_spec.rb`. 

To set up the database for the test environment run

    rake db:create TEST=1
    rake db:migrate TEST=1

Append `TEST=1` to all rake commands when you want to make those rake commands apply to the test database.

Run this `rspec` test case to check your migration worked. Remember to prefix your commands with `bundle exec` which tells Ruby to use the correct gem versions from the `Gemfile`. For example:

```
bundle exec rspec spec/migrate_create_table_spec.rb
```

Take a look at the spec file to see what fields it's expecting. How is it working?


### 2. Command line

To debug / inspect the database, it would be nice to interactively just use ActiveRecord within something like `pry`.

In this project the `config.rb` file does all the following "loading" work:

1. Requires a bunch of gems (like `active_record`)
2. Establishes a connection to the database
3. Requires our models (classes)

So we can just require that one file when we start pry. Give it a shot from the command line:

    pry -r './config.rb'

Now you should be able to interactively inspect the database using AR.

    pry(main)> Student.first
    pry(main)> Student.count

For now, we don't have any data in the database, so `Student.first` will return `nil` and `Student.count` will return `0`.

_Suggestion:_ Use a dedicated tab in your Terminal to keep a pry session open. Note thought that if you make changes to your database or code, you'll want to restart the pry session.

### 3. Import sample students

Once the students table is built and the `spec/migrate_create_table_spec.rb` test passes, let's import the sample student records from a CSV file (for convenience really):

    rake db:populate

_TIP:_ Read the rake command and the CSV importer. Do you understand what is going on? If not, discuss amongst yourselves and ask a TA for clarity.

### 4. Add a Teacher Model

Students need teachers. So let's introduce teachers to the app.

Create a `Teacher` model that extends `ActiveRecord::Base`. This model should be created in its own Ruby file and in the right folder (`app/models`).

You'll also need to create (`touch`) a new migration file in `db/migrate` to create the teachers table. 

The teachers migration file name must start with a bunch of numbers that represent the exact timestamp of when you created the migration. The students migration file is called `20140319144238_create_students.rb`. This means the migration was created on March 3rd, 2014 at 14:42:38. Precede the migration file you are about to create with a timestamp for the current date and time.

We want to store the following information about a teacher:  `name`, `email`, `address`, and `phone_number`. 


### 5. Insert sample Teacher data

Without resorting to using SQL or SQLite, write some Ruby code that uses __ActiveRecord commands__ to create some test data. Create 9 teachers, each with unique names and email addresses.

While you're at it, please ensure that no 2 teachers can share the same email address using an ActiveRecord validation. 

The students data is imported using a class we wrote called StudentsImporter in `lib/students_importer.rb`. To create the 9 teachers, create your own TeachersImporter class in `lib/teachers_importer.rb`.

Write a test to be sure creating a Teacher works and the email validation works.

#### Bonus

Implement a CSV-based mechanism for loading the sample teachers much like how `students.csv` is a convenient way to "seed" the students table with sample data. You can use much of the same code as `StudentsImporter`.

### 6. Create a One-to-Many association between Teachers and Students

At this point you should have students and teachers in the database. 

Let's say that we need each student to have a teacher, and each teacher to have many students. Does your Teacher model need to change? How about your Student model? Do you need a migration?

Make the necessary changes to your code to support this new constraint on the data.

_Tip:_ You can read about one to many and many to many relationships here: [http://guides.rubyonrails.org/association_basics.html](http://guides.rubyonrails.org/association_basics.html)

_Tip2:_ Once you are done, you should be able to do the following in your pry session:

```ruby
pry(main)> first_student = Student.first
pry(main)> first_student.teacher = Teacher.first
pry(main)> first_student.save!
pry(main)> first_student.teacher
# => returns the student's teacher
pry(main)> first_teacher = Teacher.first
pry(main)> first_teacher.students
# => returns an array that contains first_teacher
```

#### Bonus

Write tests to ensure that your association is working correctly. For example, given a student, can you find a teacher? Can you find all of her other students?

### 7. Distribute students across the teachers

Once you have associated students and teachers, write some code that will arbitrarily distribute the students fairly evenly across the teachers. Ex: If we have 12 students and 2 teachers, we want each teacher to have 6 students. If we have 20 students and 3 teachers we want one teacher to have 6 students and two teachers to have 7 students.


### 8. Uh-oh! The requirements have changed

The customer for whom you're building this system just changed her mind. It turns out that the system needs to support the notion that a student can have more than one teacher.

Make the necessary changes to your models (along with any necessary migrations) to support this.

#### Bonus

Write tests to ensure that your association is working correctly. For example, given a student, can you find her teachers? Can you find all students for a given teacher?

### 9. Spec file for students!

There is a `student_spec.rb` file in this repo. Does your code pass all of the tests? Go through and look at the validations that the student_spec file wants to enforce. Look at some of the RSpec methods being used, such as `be_valid` which tests that your validations pass on your student records.

#### Bonus

Write a `teacher_spec.rb` file to validate your Teacher model's validations. 

_Tip:_ Are there other tests that should be run on Teachers other than Students?
