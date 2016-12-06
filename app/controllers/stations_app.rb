class StationsApp < Sinatra::Base
  set :views, "#{settings.root}/../views"
  set :public_dir, "#{settings.root}/../public_dir"
  set :method_override, true

  get '/stations' do
    @stations = Station.all
    erb :'/stations/index'
  end

  get '/stations/new' do
    @cities = City.all
    erb :"/stations/new"
  end

  post '/stations' do
    station = Station.create(params[:station])
    binding.pry
    city = City.find_or_create()
    redirect "/stations/#{station.id}"
  end

  get '/stations-dashboard' do
    @stations = Station.all
    @most_recently_installed_name
    @most_recently_installed_date
    @oldest_station_name
    @oldest_station_date
    erb :"/stations/dashboard"
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
    station = Station.find(params[:id])
    station.update(params[:station])
    redirect "/stations/#{id}"
  end

  delete '/stations/:id' do |id|
    Station.destroy(id.to_i)
    redirect '/stations'
  end
end
