require 'pry'
require 'csv'
class Gossip
   attr_accessor :content, :author
   def initialize( content,author)
     @content = content
     @author = author
        
   end

  # ["Mon super auteur", "Ma super description"]
  
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@content, @author]
    end
  end
#  binding.pry

def self.all
  all_gossips = []
  CSV.read("./db/gossip.csv").each do |csv_line|
    all_gossips << Gossip.new(csv_line[0], csv_line[1])
  end
  return all_gossips
end

def self.find(id)   #methode de classe
Gossip.all[id.to_i]
end

def self.update(id,content_update,author_update)
puts id,content_update,author_update
#search the line to upate to exclude it from the db file
count=0
@content=content_update
@author=author_update
potin_id_to_delete=id.to_i
CSV.foreach('./db/gossip.csv', headers: false,col_sep:",") do |gossip_csv_line| 
  if potin_id_to_delete!=count then    # tant que la ligne à modifier n'est pas trouver on met les lignes dans le fichier temp
    File.open('./db/gossiptemp.csv','a') do |file|     
      string=gossip_csv_line[0]+","+gossip_csv_line[1]+"\n"
      file<<string
      count=count+1
    end
  end
end
File.rename("./db/gossiptemp.csv", "./db/gossip.csv")
Gossip.new(@content,@author).save
end
end