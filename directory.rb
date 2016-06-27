#!/usr/bin/env ruby
@months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
@students = []


def input_students
  puts "Please enter the list of the students"
  puts "To finish, just hit return twice"
  puts "please enter the student's name:"
  name = STDIN.gets.chomp
  cohort = :July # default

  while !name.empty? do
    puts "please enter the student's cohort, please type in a full month"
    puts "please be aware: if you did not enter any month then the defualt month is 'July'"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    while (!@months.include?(cohort)) && (!cohort.empty?) do
    puts "Please make sure that you enterd a correct full month"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    end
    cohort = :July  if cohort.empty?

    @students << {name: name, cohort: cohort}
    puts @students.count == 1? "Now we have #{@students.count} student" : "Now we have #{@students.count} students"

    puts "please enter the student's name:"
    name = STDIN.gets.chomp
  end
end




def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end



def print_students_list
  if !@students.empty?
    line_width = 25
    puts "   " +"Name".ljust(line_width) + "Cohort".center(line_width)
    puts
    puts
    @students.each_with_index() do |student, index|
      puts "#{index + 1}. #{student[:name].ljust(line_width)}#{student[:cohort].to_s.center(line_width)}"
    end
  end
  end



def print_footer
  puts @students.count == 1? "Overall, we have #{@students.count} great student" : "Overall, we have #{@students.count} great students"
end





def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
    input_students
  when "2"
    show_students
  when "3"
    save_student
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def save_student
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exist? (filename)
    load_students(filename)
    puts "Loaded #{@students.count} students, from #{filename}."
  else
    puts "Sorry, #{filename} does not exist."
    exit
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
