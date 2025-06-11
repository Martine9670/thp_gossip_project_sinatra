require_relative 'gossip' 
# Importe le fichier "gossip.rb" qui contient la classe Gossip (modèle pour gérer les potins).

class ApplicationController < Sinatra::Base 
# Déclaration de la classe ApplicationController, qui hérite de Sinatra::Base pour définir des routes web.

    get '/' do 
    # Route GET pour la page d’accueil ('/') — s’active quand un utilisateur accède à la racine du site.

        erb :index, locals: {gossips: Gossip.all}
        # Rend la vue `index.erb` et lui passe une variable locale `gossips` contenant tous les potins via Gossip.all.
    end

    get '/gossips/new/' do 
    # Route GET pour afficher le formulaire de création d’un nouveau potin.

        erb :new_gossip 
        # Rend la vue `new_gossip.erb`, qui contient le formulaire HTML.
    end

    post '/gossips/new/' do 
    # Route POST appelée quand on soumet le formulaire pour créer un potin.

        Gossip.new(params["gossip_author"], params["gossip_content"], Gossip.next_id).save 
        # Crée une nouvelle instance de Gossip avec les valeurs du formulaire, lui attribue un nouvel ID, puis la sauvegarde.

        redirect '/' 
        # Redirige l’utilisateur vers la page d’accueil une fois le potin créé.
    end

    get '/hello/:id' do 
    # Route GET test : affiche un message personnalisé selon l’ID fourni dans l’URL.

        "Hello #{params[:id]}!" 
        # Affiche le texte "Hello [ID]!" (ex. : /hello/7 ⇒ "Hello 7!").
    end

    get '/gossips/:id' do 
    # Route GET pour afficher un potin spécifique selon son ID (ex. : /gossips/3).

        @gossip = Gossip.find(params[:id]) 
        # Récupère le potin correspondant à l’ID dans l’URL et le stocke dans la variable d’instance @gossip.

        erb :show 
        # Rend la vue `show.erb`, qui va afficher les détails du potin grâce à @gossip.
    end

    get '/gossips/:id/edit/' do 
    # Route GET pour afficher le formulaire d’édition d’un potin.

        @gossip = Gossip.find(params[:id]) 
        # Récupère le potin à modifier à partir de son ID.

        erb :edit 
        # Rend la vue `edit.erb`, contenant le formulaire pré-rempli avec les infos actuelles du potin.
    end

    post '/gossips/:id/edit' do 
    # Route POST appelée quand on soumet le formulaire de modification d’un potin.

        gossip = Gossip.find(params[:id]) 
        # Récupère le potin à mettre à jour.

        gossip.update(params["gossip_author"], params["gossip_content"]) 
        # Met à jour les attributs du potin avec les nouvelles valeurs saisies dans le formulaire.

        redirect "/gossips/#{params[:id]}" 
        # Redirige vers la page du potin modifié.
    end
end
