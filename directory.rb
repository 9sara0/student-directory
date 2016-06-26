#!/usr/bin/env ruby
def input_students
  students = []
  puts "Please enter the list of the students"
  puts "To finish, just hit return twice"
  puts "please enter the student's name:"
  name = gets.chomp

  while !name.empty? do
    puts "please enter the student's hobbies"
    hobbies = gets.chomp
    puts "please enter the student's place of birth"
    place_of_birth = gets.chomp
    puts "please enter the student's hieght"
    hieght = gets.chomp

    students << {name: name, cohort: :november, hobbies: hobbies, place_of_birth: place_of_birth, hieght: hieght}
    puts "Now we have #{students.count} students"

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
  if intial_letter.upcase == "ALL"
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



def print(students)
  #command line window should be wide (expanded)
  line_width = 25
  puts "   " +"Name".ljust(line_width) + "Cohort".center(line_width) + "Hobbies".center(line_width) + "Place of Birth".center(line_width) + "Hieght".center(line_width)
  puts
  students.each_with_index() do |student, index|
    puts "#{index + 1}. #{student[:name].ljust(line_width)}#{student[:cohort].to_s.center(line_width)}#{student[:hobbies].center(line_width)}#{student[:place_of_birth].center(line_width)}#{student[:hieght].center(line_width)}"
  end
end



def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
