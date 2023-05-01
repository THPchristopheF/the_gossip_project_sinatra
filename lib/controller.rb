Bundler.require
require 'bundler'
require './lib/gossip'


class ApplicationController < Sinatra::Base     #la classe herite de la classe sinatra::base
  get '/' do        #si tu va sur http:/localhost/ tu auras cette page
    erb :index, locals: {gossips: Gossip.all}   #le contenu de la page est dans views/index.erb
  end


get '/gossips/new/' do        #si tu va sur http:/localhost/gossips/new/tu auras cette page
  erb :new_gossip   #le contenu de la page est dans views/new_gossip.erb
 end

post '/gossips/new/' do        # je te retourne les infos du formulaire
  Gossip.new(params["gossip_author"], params["gossip_content"]).save
  puts "Gossip.new(params[#{params["gossip_author"]},#{params["gossip_content"]}]"
  redirect '/'  
end

get '/gossips/:id/' do 
  erb :show, locals: { id: params[:id], a_gossip: Gossip.find(params['id'])}   #id (nom dans la vue) :params['id'] sa correspondance)
 # "le numero demandé est #{params['id']} "
 # puts "voici le numero que tu veux  #{params['id']}!"
end

get '/gossips/:id/edit/' do     #affichage du formulaire d'edition
  erb :edit, locals: {id: params[:id]}
 #puts "voici le numero que tu veux"  ##{params['id']}!"
end 

post '/gossips/:id/edit/' do
  erb :edit, locals: {id: params[:id]}
  Gossip.update(params[:id],params["gossip_author"], params["gossip_update"])
  puts "Gossip.update(params[#{params[:id]},#{params["gossip_author"]},#{params["gossip_update"]}]"
  redirect '/' 
end 

end