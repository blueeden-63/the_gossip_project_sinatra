class ApplicationController < Sinatra::Base
  get '/' do
  @gossips = Gossip.all
  erb :index
  end
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    author  = params["gossip_author"]
    content = params["gossip_content"]

    Gossip.new(author, content).save
    redirect '/'
  end
  get '/gossips/:id/' do
    id = params['id']
    @gossip = Gossip.find(id)
    erb :show
  end
end