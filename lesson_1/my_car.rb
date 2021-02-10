module Furry_dice_able
  def furry_dice?
    self.year < 2010 ? true : false
  end
end


class Vehicle
  attr_accessor :color, :model, :speed
  attr_reader :year

  @@number_of_vehicles = 0
  
  def initialize(year, model, color)
    @year  = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end

  def accelerate(amount)
    self.speed += amount
    puts "you put the pedal to the metal and are now going #{amount} kmh faster"
  end

  def brake(amount)
    self.speed -= amount
    puts "you hit the brakes and are now going #{amount} mph slower"
  end

  def current_speed
    puts "current speed is #{speed}"
  end

  def turn_off
    self.speed = 0
    puts "Let's park this thing and go for a walk" 
  end

  def spray_paint(color)
    self.color = color
  end
  
  def self.gas_mileage(gallons, miles)
    puts "mileage is #{miles / gallons} miles per gallon"
  end
  
  def self.number_of_vehicles
    puts "#{@@number_of_vehicles} vehicles have been created."
  end
  
end
 
class MyTruck < Vehicle
  MOTOR = 'bigger' 
  
  def to_s
    puts "Your truck is a #{color} #{year} #{model}."
  end
end

class MyCar < Vehicle
  include Furry_dice_able
  
  MOTOR = 'big'

  def to_s
    puts "Your car is a #{color} #{year} #{model}."
  end
end

my_car = MyCar.new(1999, 'cadi', 'blue')
my_truck = MyTruck.new(2025, 'cybertruck', 'mocca')
my_truck2 = MyTruck.new(2025, 'cybertruck', 'mocca')

my_car.current_speed
my_car.accelerate(99)
my_car.current_speed
my_car.brake(33)
my_car.current_speed
my_car.turn_off
puts
puts my_car.color
my_car.color = 'ice blue'
puts my_car.color
puts my_car.year
my_car.spray_paint('dreamy blue')
puts my_car.color
MyCar.gas_mileage(100, 300000)
puts 
puts my_car
puts my_truck
puts my_car.furry_dice?

puts MyCar.ancestors
puts '-----------------'
puts MyTruck.ancestors
puts '-----------------'
puts Vehicle.ancestors