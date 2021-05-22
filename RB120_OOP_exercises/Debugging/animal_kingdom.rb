=begin
The code below raises an exception. 
Examine the error message and alter the code so that it runs without error.
=end

class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super  # this is where the error is
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

# Solution
# Line 7 - The initialize method of the animal class accepts 2 arguments
# Line 55 - The `robin` instance of SongBird passes in 3 arguments
# Since Songbird class inherits from Bird class, and the initialize method
# in Songbird has the word super, it passes all three arguments up the 
# method look up chain to the Bird class, which in turn passes them up to 
# the `Animal` class that only accepts two arguments.
# Therefore to correct the error, two arguments, i.e. `super(diet, superpower)` 
# must be written on line 42 in lieu of `super`.

# Further Exploration
# Is the FlightlessBird#initialize method necessary? Why or why not?
# The FlightlessBird#initialize method is not necessary, because it has no
# additional content than the `initialize` method of `Animal` class from which
# it already inherits an `initialize` method. 