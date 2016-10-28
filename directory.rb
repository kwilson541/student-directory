# Arrays accessible to all methods
@students = []
@months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

# Interactive menu available when program is run
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  # Print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the student list to students.csv"
  puts "4. Load the list of students from students.csv"
  # 9 Because we'll be adding more items
  puts "9. Exit"
end

# Display details of all available students, formatted with header and footer
def show_students
  print_header
  print_students_list
  print_footer
end

# Interactive menu options
def process(selection)
  case selection
    when "1"
      puts "Inputting students..."
      students = input_students
    when "2"
      puts "Displaying students..."
      show_students
    when "3"
      save_students
      puts "Students saved"
    when "4"
      load_students
      puts "Student list loaded"
    when "9"
      puts "Exiting program"
      exit # This will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

# Allows user to save inputted student information to file
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

# Loads a student list, default file is students.csv
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  # Takes each line of the file, splits the student info, and converts to variables
  file.readlines.each do |line|
  @name, @cohort, @origin, @dob = line.chomp.split(',')
    add_student
  end
  file.close
end

# Loads a list of students from file
def try_load_students
  #First argument from the command line
  filename = ARGV.first
  # Get out of the method if it isn't given
  if filename.nil?
    load_students("students.csv")
    puts "No filename entered, loaded students.csv"
  # If it exists
  elsif File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  #If it doesn't exist
  else
    puts "Sorry, #{filename} doesn't exist."
    # Quit the program
    exit
  end
end

# Takes student variables and puts them into a hash, which is added to the students array
def add_student
  @students << {name: @name, cohort: @cohort.to_sym, origin: @origin, dob: @dob}
end

def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  puts "Student name:"

  gather_student_data

  @students
end

# Gathers student information, which is input by the user
def gather_student_data
  @name = STDIN.gets.chomp
  # If a name is entered, gets student cohort, origin and dob, then offers to input next student
  while !@name.empty? do
    gather_cohort
    gather_origin
    gather_dob
    # Add the student hash to the array
    add_student
    puts "Now we have #{@students.count} students"
    # Get another name from the user
    puts "Please enter the details of next student"
    puts "Student name:"
    @name = STDIN.gets.chomp
  end
end

# Gathers student cohort, a valid month must be entered
def gather_cohort
  puts "#{@name}'s cohort:"
    @cohort = STDIN.gets.chomp.capitalize.to_sym
    @cohort = :November if @cohort.empty?
    until @months.include? @cohort
      puts "Please enter a valid month"
      @cohort = STDIN.gets.chomp.capitalize.to_sym
    end
end

# Gathers student origin
def gather_origin
  puts "#{@name}'s origin:"
  @origin = STDIN.gets.chomp
end

# Gathers student dob
def gather_dob
  puts "#{@name}'s date of birth (DD/MM/YYYY):"
  @dob = STDIN.gets.chomp
end

def print_header
  # Prints the header, if there are any students to display
  if @students.count > 0
  puts "The students of Villains Academy"
  puts "-------------".center(30)
  end
end
 
def print_students_list
  # Prints the list of students and their information
  count = 0
  until count == @students.length
    puts "Name: #{@students[count][:name]}, Origin: #{@students[count][:origin]}, DOB: #{@students[count][:dob]}, Cohort: #{@students[count][:cohort]}"
    count += 1
  end
end

def print_footer
  # Determines whether student(s) sho@ld be singular or plural
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

  @specific_letter = STDIN.gets.chomp
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
  cohort_input = STDIN.gets.chomp.capitalize.to_sym
  @students.each { |student|
    if student[:cohort] == cohort_input
    puts "Name: #{student[:name]}, Origin: #{student[:origin]}, DOB: #{student[:dob]}"
  end
}
end

# Nothing happens until we call the methods
try_load_students
interactive_menu