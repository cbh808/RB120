# Modify this class so both flip_switch and the setter method switch= are private methods.
=begin
class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end
=end

class Machine

  def start
    flip_switch(:on) # self.flip_switch(:on) OK in Ruby 2.7 or higher
  end

  def stop
    flip_switch(:off) # self.flip_switch(:off) OK in Ruby 2.7 or higher
  end

  def get_switch_state
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Further Exploration
# Add a private getter for @switch to the Machine class,
# and add a method to Machine that shows how to use that getter.

class Machine

  def start
    flip_switch(:on)
  end
  
  def stop
    flip_switch(:off)    
  end

  def switch_on?
    switch
  end

  private

  attr_accessor :switch
  
  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

printer = Machine.new
printer.start
printer.stop
puts printer.get_switch_state