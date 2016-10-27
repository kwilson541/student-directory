def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  puts "Student name:"

  students = []

  name = gets.chomp

  months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

  while !name.empty? do
    puts "#{name}'s cohort:"
    cohort = gets.chomp.capitalize.to_sym
    cohort = :November if cohort.empty?
    until months.include? cohort
      puts "Please enter a valid month"
      cohort = gets.chomp.capitalize.to_sym
    end
    puts "#{name}'s origin:"
    # .chop used as an alternative to .chomp
    origin = gets.chop
    puts "#{name}'s date of birth (DD/MM/YYYY):"
    dob = gets.chomp
    # Add the student hash to the array
    students << {name: name, cohort: cohort, origin: origin, dob: dob}
    puts "Now we have #{students.count} students"
    # Get another name from the user
    puts "Please enter the details of next student"
    puts "Student name:"
    name = gets.chomp
  end

  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------".center(30)
end

def print(students)
  count = 0
  until count == students.length
    puts "Name: #{students[count][:name]}, Origin: #{students[count][:origin]}, DOB: #{students[count][:dob]}, Cohort: #{students[count][:cohort]}"
    count += 1
  end
end

def print_footer(students)
  sgpl = "students"
  if students.count == 1
    sgpl = "student"
  end
  puts "Overall, we have #{students.count} great #{sgpl}"
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
      puts "#{students[:name]} (#{students[:cohort]} cohort)"
    end
  }
end

# Only prints student names if they are shorter than 12 characters
def print_shorter_than_12(students)
  students.each { |student|
    if student[:name].length < 12
      puts "#{students[:name]} (#{students[:cohort]} cohort)"
    end
    }
end

# Prints students organised by Cohort
def print_by_cohort(students)
 cohorts = students.map { |students| students[:cohort] }
 puts "You have students from the following cohorts:"
 cohorts.each { |cohort| cohort.to_s
  puts "#{cohort}"
  }
  puts "Which cohort would you like to display:"
  cohort_input = gets.chomp.capitalize.to_sym
  students.each { |student|
    if student[:cohort] == cohort_input
    puts "Name: #{student[:name]}, Origin: #{student[:origin]}, DOB: #{student[:dob]}"
  end
}
end

# Nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)