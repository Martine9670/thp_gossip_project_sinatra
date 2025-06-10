require_relative 'gossip'

class ApplicationController < Sinatra::Base
    get '/' do
        erb :index, locals: {gossips: Gossip.all}
    end

    get '/gossips/new/' do
        erb :new_gossip
    end

    post '/gossips/new/' do
        Gossip.new(params["gossip_author"], params["gossip_content"], Gossip.next_id).save
        redirect '/'
    end

    get '/hello/:id' do
        "Hello #{params[:id]}!"
    end

    get '/gossips/:id' do
        @gossip = Gossip.find(params[:id])
        erb :show
    end

    get '/gossips/:id/edit/' do
        @gossip = Gossip.find(params[:id])
        erb :edit
    end

    post '/gossips/:id/edit' do
        gossip = Gossip.find(params[:id])
        gossip.update(params["gossip_author"], params["gossip_content"])
        redirect "/gossips/#{params[:id]}"
    end
end
