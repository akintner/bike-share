class BikeShareApp < Sinatra::Base
  set :method_override, true

  get '/stations' do
    @stations = Station.all
    erb :"/stations/index"
  end

  get '/stations/new' do
    erb :"/stations/new"
  end

  post '/stations' do
    station = Station.create(params[:station])
    redirect "/stations/#{station.id}"
  end

  get '/stations/:id' do
    @station = Station.find(params[:id])
    erb :"/stations/show"
  end

  get '/stations/:id/edit' do
    @station = Station.find(params[:id])
    erb :"/stations/edit"
  end

  put '/stations/:id' do |id|
    Station.update(params[:station])
    redirect "/stations/#{id}"
  end

  delete '/stations/:id' do |id|
    Station.destroy(id.to_i)
    redirect '/stations'
  end

end
