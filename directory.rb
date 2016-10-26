def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Create an empty array
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    # Add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # Get another name from the user
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
  students.each_with_index { |student, num|
    puts "#{num + 1} #{student[:name]} (#{student[:cohort]} cohort)"
	}
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
    if student[:name].chars.first == specific_letter
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  }
end

# Nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
specific_letter = input_letter
print_specific_letter(students, specific_letter)