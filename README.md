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

Migrations are AR's way for allowing us to modify the database using ruby code, and to modify it incrementally.

Read about migrations here (to understand them, don't worry about memorizing the different approaches, etc): <http://guides.rubyonrails.org/migrations.html>

## Objectives

### 1. Setup Students table

There is a Student model already. But the database does not yet have the `students` table. In fact you don't even have a development database to work against yet.

We need to create an empty database and then update the SCHEMA (structure) to include a `students` table. We will use migrations for this.

#### Step 1 - Create DB

Run the rake command to create the database file: `rake db:create`

How does that work? What does it do? Hint: take a look at the `Rakefile`

#### Step 2 - Create `students` table

Modify the migration in the `db/migrate` folder and implement the `up` and `down` methods.

Once you implement it, run `rake db:migrate` to run the migration against the database.

#### Step 3 - Make sure the tests pass

You'll know you did it right (created the table that was expected) if running the appropriate test (`spec/migrate_create_table_spec.rb`) using `rspec` passes.

Take a look at the spec file to see what fields it's expecting. How is it working?

### 2. Import sample students

Once the students table is built and the `spec/migrate_create_table_spec.rb` test passes, let's import the sample student records from a CSV file (for convenience really):

    rake db:populate

_TIP:_ Read the rake command and the CSV importer. Do you understand what is going on? If not, discuss amongst yourselves and ask a TA for clarity.

### 3. Command line

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

_Suggestion:_ Use a dedicated tab in your Terminal to keep a pry session open. Note thought that if you make changes to your database or code, you'll want to restart the pry session.

### 4. Add a Teacher Model

Students are useless without teachers. So let's introduce teachers to the app.

Create a `Teacher` model that extends `ActiveRecord::Base`.

It should have attributes to store the teacher's `name`, `email` `address`, and `phone_number`.

This model should be created in its own Ruby file and in the right folder (`app/models`). You'll also need to create (`touch`) a new migration file to make sure the table gets created.

### 5. Insert sample Teacher data

Without resorting to using SQL or SQLite, write some Ruby code that uses ActiveRecord commands to create some test data. Create 9 teachers, each with unique names and email addresses.

While you're at it, please ensure that no 2 teachers can share the same email address using an ActiveRecord validation. Write a test to be sure that it works.

#### Bonus

Implement a CSV-based mechanism for loading the sample teachers much like how `students.csv` is a convenient way to "seed" the students table with sample data. You can use much of the same code as `StudentsImporter`.

### 6. Create a One-to-Many association between Teachers and Students

Let's assume for the time being that each student has only 1 teacher, and each teacher can have many students. Does your Teacher model need to change? How about your student model? Do you need a migration?

Make the necessary changes to your code to support this new constraint on the data.

Once you've done that, write some code that will arbitrarily distribute the students fairly evenly across the teachers.

#### Bonus
Write tests to ensure that your association is working correctly. For example, given a student, can you find a teacher? Can you find all of her students?

### Uh-oh! The requirements have changed
The customer for whom you're building this system just changed her mind. It turns out that the system needs to support the notion that a student can have more than one teacher.

Make the necessary changes to your models (along with any necessary migrations) to support this.

#### Bonus
Write tests to ensure that your association is working correctly. For example, given a student, can you find her teachers? Can you find all students for a given teacher?
