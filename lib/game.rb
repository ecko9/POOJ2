require_relative 'player'

class Game

  attr_accessor :human_player, :enemies

  def initialize(name)
    init_bots
    @human_player = init_player(name)
    @enemies = Player.all
    @enemies.pop
    p @enemies
    perform
  end


#########################################################

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
  puts " -- La partie est finie --   "
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


#########################################################

  ### INITIALISATION BOTS PLAYERS
  def init_bots
    p1 = Player.new("Jose")
    p2 = Player.new("Martin")
    p3 = Player.new("Francis")
    p4 = Player.new("Karim")
  end


#########################################################

  ### INITIALISATION OBJET DE LA CLASSE HumanPlayer
  def init_player(name)
    return player = HumanPlayer.new(name)
  end

#########################################################


  ### BOT EN VIE ?
  def bot_alive(bots)
    bots.each do |bot|
      if bot.life_points > 0
        return true
      end
    end
    return false
  end


#########################################################

  ### ELIMINE JOUEUR MORT
  def kill_player(player)
    @enemies.each do |bot|
      if player == bot
        @enemies.delete_at(@enemies.index(bot))
      end
    end
  end


#########################################################

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

########################################################

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
    bots.each do |bot|
      puts "#{bots.index(bot).to_i} >  #{bot.name}(#{bot.life_points})"
    end
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
    else
      if input.to_i >= 0 && input.to_i <= bots.length
        player.attacks(bots[input.to_i])
      else
        puts "Erreur : Mauvaise option !"
        puts "Veuillez selectionner une option parmis les suivantes :"
        phase_2(player, bots)
      end
    end
  end

#########################################################

  ### PHASE 3
  # ATTAQUE DES BOTS
  def phase_3(player, bots)
    puts "   -----------------------   "
    puts "   --    TOUR ENNEMI    --   "
    puts "   -----------------------   "
    puts ""
    bots.each do |bot|
      if bot.life_points > 0
        bot.attacks(player)
      else
        kill_player(bot)
      end
    end
  end


#########################################################


  ### TOURS DE JEU
  def turns(player, bots)
    while player.life_points > 0 && bot_alive(bots)
      phase_1(player)
      gets.chomp
      phase_2(player, bots)
      gets.chomp
      phase_3(player, bots)
      gets.chomp
    end 
  end


#########################################################
  #############################################
  #################################
  #####################
  ###########
  #####
  #
  def perform
  launch_screen
  turns(@human_player, @enemies)
  end_screen(@human_player)
  end

#########################################################  
end