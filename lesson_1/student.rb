=begin
Create a class 'Student' with attributes name and grade. 
Do NOT make the grade getter public, so joe.grade will raise an error. 
Create a better_grade_than? method, that you can call like so...
=end

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(dude)
    grade > dude.grade
  end

  protected  # grade can now only be called inside class

  def grade
    @grade
  end
end

joe = Student.new('joe', 99)
bob = Student.new('bob', 98)

puts "Well done!" if joe.better_grade_than?(bob)