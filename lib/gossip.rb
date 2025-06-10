require 'csv'

class Gossip
    attr_reader :gossip_author, :gossip_content

        def initialize(gossip_author, gossip_content)
        @gossip_author = gossip_author
        @gossip_content = gossip_content
        end


    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@gossip_author, @gossip_content]
        end
    end

    def self.all
        all_gossips = [] # On initialise un array vide
        CSV.read("./db/gossip.csv").each do |csv_line| # Va chercher chacune des lignes du csv do
            all_gossips << Gossip.new(csv_line[0], csv_line[1]) # Crée un gossip avec les infos de la ligne
        end
        return all_gossips # Retourne un array rempli d'objets Gossip
    end
end