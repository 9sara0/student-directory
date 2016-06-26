#!/usr/bin/env ruby
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []
  name = gets.chomp

  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"

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

def print(students)
  students.each_with_index() {|student, index| puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"}
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(slected_first_letter_names(students))
print_footer(students)
