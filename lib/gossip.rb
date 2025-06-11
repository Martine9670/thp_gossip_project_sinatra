require 'csv' # Importe la bibliothèque standard CSV de Ruby, pour lire et écrire dans des fichiers CSV.

class Gossip
  attr_reader :gossip_author, :gossip_content, :id # Crée des accesseurs en lecture (getter) pour les attributs : auteur, contenu et id du potin.

    def initialize(gossip_author, gossip_content, id)
        @gossip_author = gossip_author           # Attribue l'auteur à une variable d'instance.
        @gossip_content = gossip_content         # Attribue le contenu du potin à une variable d'instance.
        @id = id.to_i                            # Convertit l'ID en entier et le stocke.
    end
    def save
        @id = Gossip.next_id if @id == 0                   # Si l'ID est 0 (non défini), on génère un nouvel ID unique automatiquement.
        CSV.open("./db/gossip.csv", "ab") do |csv|         # Ouvre le fichier CSV en mode "append binary" (ajoute à la fin).
            csv << [@gossip_author, @gossip_content, @id]  # Écrit une ligne avec les infos du potin.
        end
    end


    def self.all
        all_gossips = []                    # Initialise un tableau vide pour stocker tous les potins.
        if File.exist?("./db/gossip.csv")   # Vérifie si le fichier existe avant de le lire.
        CSV.read("./db/gossip.csv").each do |csv_line|    # Lit chaque ligne du fichier CSV.
            all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])   # Crée un objet Gossip à partir de chaque ligne et l’ajoute à la liste.
        end
        end
        all_gossips   # Retourne la liste de tous les potins.
    end

    def self.find(id)
        self.all.find { |gossip| gossip.id == id.to_i }   # Recherche dans tous les potins celui dont l'ID correspond à celui donné.
    end

    def self.next_id
        all.empty? ? 1 : all.map(&:id).max + 1   # Si aucun potin n'existe, retourne 1 comme premier ID. Sinon, retourne le plus grand ID + 1 pour éviter les doublons.
    end

    def update(new_author, new_content)
    gossips = Gossip.all.map do |gossip|       # Parcourt tous les potins et construit une nouvelle liste.
        if gossip.id == self.id                # Si l’ID correspond à celui du potin à modifier. 
        Gossip.new(new_author, new_content, gossip.id)  # Crée un nouveau potin avec les nouvelles infos.
        else
        gossip    # Sinon, garde le potin inchangé.
        end
    end

    CSV.open('./db/gossip.csv', 'w') do |csv|    # Réécrit entièrement le fichier CSV avec la nouvelle liste.
            gossips.each do |g|                  # Pour chaque potin mis à jour ou non.
            csv << [g.gossip_author, g.gossip_content, g.id]   # Écrit une ligne avec les nouvelles données dans le fichier.
            end
        end
    end
end
