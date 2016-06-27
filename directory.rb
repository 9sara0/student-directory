#!/usr/bin/env ruby
require 'csv'
@months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
@students = []


def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end


def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_student(get_filename("save"))
  when "4"
    load_students(get_filename("load"))
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end


def ask_user_for_names
  puts "please enter the student's name:"
  puts "To finish, just hit return twice"
end

def ask_user_for_cohort
  puts "please enter the student's cohort, please type in a full month"
  puts "please be aware: if you did not enter any month then the defualt month is 'July'"
end



def user_input
  STDIN.gets.chomp
end

def input_students
  ask_user_for_names
  name = user_input
  cohort = :July # default

  while !name.empty? do
    ask_user_for_cohort
    cohort = user_input.capitalize.to_sym
    while (!@months.include?(cohort)) && (!cohort.empty?) do
    puts "Please make sure that you enterd a correct full month"
    cohort = user_input.capitalize.to_sym
    end
    cohort = :July  if cohort.empty?

    update_students(name, cohort)

    puts @students.count == 1? "Now we have #{@students.count} student" : "Now we have #{@students.count} students"

    ask_user_for_names
    name = user_input
  end
end


def show_students
  print_header
  print_students_list
  print_footer
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
    @students.each_with_index() do |student, index|
      puts "#{index + 1}. #{student[:name].ljust(line_width)}#{student[:cohort].to_s.center(line_width)}"
    end
  end
  end



def print_footer
  puts @students.count == 1? "Overall, we have #{@students.count} great student" : "Overall, we have #{@students.count} great students"
  puts
end


def ask_user_for_filename (option)
  puts "Where do you want to #{option} it?"      if option == "save"
  puts "From where do you want to #{option} it?" if option == "load"
  puts "Please type in the file name with its extension"
end

def get_filename(option)
  ask_user_for_filename(option)
  user_input
end

def save_load_feedbak(option)
  puts "#{option} was done successfully"
end


def save_student(filename = "students.csv")
  CSV.open(filename, "a+") do |csv|
  @students.each do |student|
    csv << [student[:name], student[:cohort]]
  end
  end
  save_load_feedbak("save")
end



def load_students(filename = "students.csv")
  CSV.foreach(filename) do |line|
    name, cohort = line.join(',').chomp.split(',')
    update_students(name, cohort.to_sym)
  end
  save_load_feedbak("load")
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exist? (filename)
    load_students(filename)
    puts "Loaded #{@students.count} students, from #{filename}."
  else
    puts "Sorry, #{filename} does not exist."
    exit
  end
end



def update_students(name, cohort = :July)
  @students << {name: name, cohort: cohort}
end

def interactive_menu
  loop do
    print_menu
    process(user_input)
  end
end

try_load_students
interactive_menu
