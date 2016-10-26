def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  puts "Student name:"
  # Create an empty array
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    puts "#{name}'s origin:"
    origin = gets.chomp
    puts "#{name}'s date of birth (DD/MM/YYYY):"
    dob = gets.chomp
    # Add the student hash to the array
    students << {name: name, cohort: :November, origin: origin, dob: dob}
    puts "Now we have #{students.count} students"
    # Get another name from the user
    puts "Please enter the details of next student"
    puts "Student name:"
    name = gets.chomp
  end
  # Return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  count = 0
  until count == students.length
    puts "Name: #{students[count][:name]}, Origin: #{students[count][:origin]}, DOB: #{students[count][:dob]}, Cohort: #{students[count][:cohort]}"
    count += 1
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

# Gets a specific letter from the User
def input_letter
  puts "Please enter a letter"
  puts "Only students names that begin with this letter will be displayed"

  specific_letter = gets.chomp
end

# Only prints students names if they begin with a specific letter
def print_specific_letter(students, specific_letter)
  students.each { |student|
    if student[:name].chars.first.downcase == specific_letter.downcase
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  }
end

# Only prints student names if they are shorter than 12 characters
def print_shorter_than_12(students)
  students.each { |student|
    if student[:name].length < 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
    }
end

# Nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)