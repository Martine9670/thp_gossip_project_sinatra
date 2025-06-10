require 'csv'

class Gossip
  attr_reader :gossip_author, :gossip_content, :id

    def initialize(gossip_author, gossip_content, id)
        @gossip_author = gossip_author
        @gossip_content = gossip_content
        @id = id.to_i
    end

    def save
        @id = Gossip.next_id if @id == 0
        CSV.open("./db/gossip.csv", "ab") do |csv|
        csv << [@gossip_author, @gossip_content, @id]
        end
    end

    def self.all
        all_gossips = []
        if File.exist?("./db/gossip.csv")
        CSV.read("./db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
        end
        end
        all_gossips
    end

    def self.find(id)
        self.all.find { |gossip| gossip.id == id.to_i }
    end

    def self.next_id
        all.empty? ? 1 : all.map(&:id).max + 1
    end

    def update(new_author, new_content)
    gossips = Gossip.all.map do |gossip|
        if gossip.id == self.id
        Gossip.new(new_author, new_content, gossip.id)
        else
        gossip
        end
    end

    CSV.open('./db/gossip.csv', 'w') do |csv|
            gossips.each do |g|
            csv << [g.gossip_author, g.gossip_content, g.id]
            end
        end
    end
end
