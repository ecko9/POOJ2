require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

p1 = Player.new("José")
p2 = Player.new("Josiane")


while p1.life_points > 0 && p2.life_points > 0
  puts "   -----------------------   "
  puts "Voici l'état de chaque joueur :"
  puts ""
  p1.show_state
  p2.show_state
  puts ""
  puts "Passons a la phase d'attaque :"
  puts ""
  if p1.life_points > 0
    p1.attacks(p2)
  end
  if p2.life_points > 0
    p2.attacks(p1)
  end
  puts ""
  puts "   -----------------------   "
end 
#binding.pry