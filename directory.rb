#!/usr/bin/env ruby
@months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]

def input_students
  students = []
  puts "Please enter the list of the students"
  puts "To finish, just hit return twice"
  puts "please enter the student's name:"
  name = gets.chomp
  cohort = :July # default

  while !name.empty? do
    puts "please enter the student's cohort, please type in a full month"
    puts "please be aware: if you did not enter any month then the defualt month is 'July'"
    cohort = gets.chomp.capitalize.to_sym
    while (!@months.include?(cohort)) && (!cohort.empty?) do
    puts "Please make sure that you enterd a correct full month"
    cohort = gets.chomp.capitalize.to_sym
    end
    cohort = :July  if cohort.empty?

    puts "please enter the student's hobbies"
    hobbies = gets.chomp
    puts "please enter the student's place of birth"
    place_of_birth = gets.chomp
    puts "please enter the student's hieght"
    hieght = gets.chomp

    students << {name: name, cohort: cohort, hobbies: hobbies, place_of_birth: place_of_birth, hieght: hieght}
    puts students.count == 1? "Now we have #{students.count} student" : "Now we have #{students.count} students"

    puts "please enter the student's name:"
    name = gets.chomp
  end
  students
end



def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end



def slected_first_letter_names(students)
  puts "Please type in a letter to get a list of students whose name begins with that letter."
  puts "Type in 'all' to get the complete list with all student names"
  intial_letter = gets.chomp
  if intial_letter.upcase == "ALL" || intial_letter.empty?
    return students
  else
  names_with_specified_letter = []
  students.each do |student|
    if student[:name].upcase[0] == intial_letter[0].upcase
      names_with_specified_letter << student
    end
  end
      return names_with_specified_letter
    end
end

def shorter_than12(students)

  names_less_than12 = []
  students.each do |student|
    if student[:name].length < 12
      names_less_than12 << student
    end
  end
  return names_less_than12
end


def cohort_sort(students)
  puts "Please type in a month to get the list of students from that cohort"
  puts "Type in 'all' to get the complete list with all student names"
  puts "Please remmeber if you hit return, you will get the default month cohort 'July'"
  month = gets.chomp.capitalize.to_sym
  while (!@months.include?(month)) && (!month.empty?) && (month.to_s.upcase != "ALL") do
  puts "Please make sure that you enterd a correct full month"
  month = gets.chomp.capitalize.to_sym
  end
  month = :July  if month.empty?

  if month.to_s.upcase == "ALL"
    return students
  else
    slected_list = students.select {|k| (k[:cohort].to_s.upcase == month.to_s.upcase)}
  end
#  to sort the sudents by their cohort: sorted_list = students.sort_by { |k| k[:cohort].to_s.upcase }
end



def print(students)
  if !students.empty?
    line_width = 25
    puts "   " +"Name".ljust(line_width) + "Cohort".center(line_width) + "Hobbies".center(line_width) + "Place of Birth".center(line_width) + "Hieght".center(line_width)
    puts
    puts
    students.each_with_index() do |student, index|
      puts "#{index + 1}. #{student[:name].ljust(line_width)}#{student[:cohort].to_s.center(line_width)}#{student[:hobbies].center(line_width)}#{student[:place_of_birth].center(line_width)}#{student[:hieght].center(line_width)}"
    end
  end
  end



def print_footer(students)
  puts students.count == 1? "Overall, we have #{students.count} great student" : "Overall, we have #{students.count} great students"
end


students = input_students
print_header
print(students)
print_footer(students)
