
class Player

  attr_accessor :name, :life_points
  @@joueurs = []
  
  def initialize(name)
    @name = name.to_s
    @life_points = 10
    @@joueurs.push(self)
  end

  ### TABLEAU DES JOUEURS
  def self.all
    return @@joueurs
  end

  ### AFFICHER NOM ET PV DU JOUEUR
  def show_state
    puts "#{@name} à #{@life_points} points de vie"
  end

  ### ACTION RECEVOIR DOMMAGES
  def gets_damage(dmg)
    #puts self.show_state
    puts "L'attaque inflige à #{@name} #{dmg} dégats"
    @life_points = @life_points - dmg
    if @life_points <= 0 
      puts "Le joueur #{@name} est mort!"
    else
      puts self.show_state
    end
    return @life_points
  end

  ### ACTION ATTAQUER (INFLIGER DOMMAGES)
  def attacks(player)
    puts "#{@name} attaque le joueur #{player.name}"
    player.gets_damage(compute_damage)
  end

  ### GENERATEUR DE DEGATS ALEATOIRE (1 a 6)
  def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player

  attr_accessor :weapon_level, :life_points

  def initialize(name)
    super(name)
    @weapon_level = 1
    @life_points = 100  
  end

  ### AFFICHER NOM, PV ET NIVEAU ARME DU JOUEUR
  def show_state
    puts "#{@name} à #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  ### GENERATEUR DE DEGATS ALEATOIRE (1 a 6) FOIS LVL ARME
  def compute_damage
    return rand(1..6) * @weapon_level
  end

  ### CHANGER D'ARME (CHERCHER UNE NOUVELLE)
  def search_weapon
    lvl = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{lvl}"
    if @weapon_level >= lvl
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    else
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      @weapon_level = lvl
    end
  end

  ### CHERCHER UN PACK DE SOIN
  def search_health_pack
    des = rand(1..6)
    if des == 1 
      puts "Tu n'as rien trouvé..."
    elsif des >=2 && des <= 5
      @life_points = @life_points + 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      @life_points = @life_points + 80
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end

    if @life_points > 100
      @life_points = 100
    end
  end



end
