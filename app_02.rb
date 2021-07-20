require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

### ECRAN ACCUEIL
def launch_screen
  puts ""
  puts "-------------------------------------------------"
  puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
  puts ""
end



### ECRAN FIN DE PARTIE
def end_screen(player)
  puts "   -----------------------   "
  puts ""
  puts " -- La partie est finie --"
  puts ""
  puts "   -----------------------   "
  puts ""
  if player.life_points > 0
    puts "Félicitations, Vous remportez la partie !"
    puts ""
    puts "   -----------------------   "
  else
    puts "Dommage, Vous avez perdu la partie !"
    puts ""
    puts "   -----------------------   "
  end
end


### DEMANDE AU JOUEUR SON NOM ET INITIALISATION OBJET DE LA CLASSE HumanPlayer
def init_player
  puts "   -----------------------   "
  puts "Veuillez saisir un nom de joueur :"
  puts ""
  print "> "
  nom_joueur = gets.chomp.to_s
  puts "   -----------------------   "
  return player = HumanPlayer.new(nom_joueur)
end




### INITIALISATION DES ENNEMIS NON JOUEURS (BOTS)
def init_bots
  p1 = Player.new("José")
  p2 = Player.new("Josiane")
end



### PHASE 1
#AFFICHAGE SANTE DU JOUEUR ET NIVEAU ARME
def phase_1(player)
  puts "   -----------------------   "
  puts "   --   SANTE / ARME    --   "
  puts "   -----------------------   "
  puts ""
  player.show_state
  puts ""
end



### PHASE 2
#AFFICHAGE DU MENU D'ACTIONS JOUEUR
def phase_2(player, bots)
  puts "   -----------------------   "
  puts "   --       MENU        --   "
  puts "   -----------------------   "
  puts "   -----------------------   "
  puts "   --      ACTION       --   "
  puts ""
  puts "a > chercher une meuilleure arme"
  puts "s > chercher à se soigner"
  puts ""
  puts ">>> attaquer un ennemi en vue :"
  puts "0 >  #{bots[1].name}(#{bots[1].life_points})"
  puts "1 >  #{bots[2].name}(#{bots[2].life_points})"
  puts ""
  puts "   -----------------------   "
  input = gets.chomp.to_s
  menu(input, player, bots)
end

### SELECT ACTION MENU
def menu(input, player, bots)
  if input == "a"
    player.search_weapon
  elsif input == "s"
    player.search_health_pack
  elsif input == "0"
    player.attacks(bots[1])
  elsif input == "1"
    player.attacks(bots[2])
  else
    puts "Erreur : Mauvaise option !"
    puts "Veuillez selectionner une option parmis les suivantes :"
    phase_2(player, bots)
  end
end



### PHASE 3
# ATTAQUE DES BOTS
def phase_3(player, bots)
  puts "   -----------------------   "
  puts "   --    TOUR ENNEMI    --   "
  puts "   -----------------------   "
  puts ""
  i = 0
  bots.each do |bot|
    if i > 0 && bot.life_points > 0
      bot.attacks(player)
    end
    i += 1
  end
end





### TOURS DE JEU
def turns(player, bots)
  while player.life_points > 0 && (bots[1].life_points > 0 || bots[2].life_points > 0)
    phase_1(player)
    gets.chomp
    phase_2(player, bots)
    gets.chomp
    phase_3(player, bots)
    gets.chomp
  end 
end



###########################################
#################################
#####################
###########
#####
#
def perform
launch_screen
player = init_player
init_bots
bots = Player.all
turns(player, bots)
end_screen(player)
end
perform
#binding.pry