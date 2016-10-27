# An empty array accessible to all methods
@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  # Print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the student list to students.csv"
  # 9 Because we'll be adding more items
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit # This will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each { |student|
    student_data = [student[:name], student[:cohort], student[:origin], student[:dob]]
    csv_line = student_data.join(",")
    file.puts csv_line
  }
  file.close
end

def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  puts "Student name:"

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
    @students << {name: name, cohort: cohort, origin: origin, dob: dob}
    puts "Now we have #{@students.count} students"
    # Get another name from the user
    puts "Please enter the details of next student"
    puts "Student name:"
    name = gets.chomp
  end

  @students
end

def print_header
  if @students.count > 0
  puts "The students of Villains Academy"
  puts "-------------".center(30)
  end
end
 
def print_students_list
  count = 0
  until count == @students.length
    puts "Name: #{@students[count][:name]}, Origin: #{@students[count][:origin]}, DOB: #{@students[count][:dob]}, Cohort: #{@students[count][:cohort]}"
    count += 1
  end
end

def print_footer
  sgpl = "students"
  if @students.count == 1
    sgpl = "student"
  end
  if @students.count > 0
  puts "Overall, we have #{@students.count} great #{sgpl}"
  else
  puts "You have no students!"
  end
end

# Gets a specific letter from the User
def input_letter
  puts "Please enter a letter"
  puts "Only students names that begin with this letter will be displayed"

  @specific_letter = gets.chomp
end

# Only prints students names if they begin with a specific letter
def print_specific_letter
  @students.each { |student|
    if student[:name].chars.first.downcase == @specific_letter.downcase
      puts "#{@students[:name]} (#{@students[:cohort]} cohort)"
    end
  }
end

# Only prints student names if they are shorter than 12 characters
def print_shorter_than_12
  @students.each { |student|
    if student[:name].length < 12
      puts "#{@students[:name]} (#{@students[:cohort]} cohort)"
    end
    }
end

# Prints students organised by Cohort
def print_by_cohort
 cohorts = @students.map { |students| students[:cohort] }
 puts "You have students from the following cohorts:"
 cohorts.each { |cohort| cohort.to_s
  puts "#{cohort}"
  }
  puts "Which cohort would you like to display:"
  cohort_input = gets.chomp.capitalize.to_sym
  @students.each { |student|
    if student[:cohort] == cohort_input
    puts "Name: #{student[:name]}, Origin: #{student[:origin]}, DOB: #{student[:dob]}"
  end
}
end

# Nothing happens until we call the methods
interactive_menu