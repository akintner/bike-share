require 'will_paginate'
require 'will_paginate/active_record'
require 'pry'

class BikeShareApp < Sinatra::Base
  set :method_override, true
  include WillPaginate::Sinatra::Helpers

  get '/stations' do
    redirect '/stations/?page=1'
  end

  get '/stations/' do
    @stations = Station.paginate(:page => params[:page], :per_page => 30)
    erb :"/stations/index"
  end

  get '/stations/new' do
    @cities = City.all
    erb :"/stations/new"
  end

  post '/stations' do
    city = City.find_or_create_by(name: params[:city])
    station = Station.create(params[:station])
    station.city_id = city.id
    station.save
    redirect "/stations/#{station.id}"
  end

  get '/stations-dashboard' do
    @stations = Station.all
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

  put '/stations/:id' do
    station = Station.find(params[:id])
    station.update(params[:station])
    redirect "/stations/#{station.id}"
  end

  delete '/stations/:id' do
    Station.destroy(params[:id])
    redirect '/stations'
  end

  get '/cities' do
    @cities = City.all
    erb :"cities/index"
  end

  get '/cities/new' do
    erb :"cities/new"
  end

  post '/cities' do
    city = City.create(params[:city])
    redirect "/cities/#{city.id}"
  end

  get '/cities/:id' do
    @city = City.find(params[:id])
    erb :"/cities/show"
  end

  get '/cities/:id/edit' do
    @city = City.find(params[:id])
    erb :"/cities/edit"
  end

  put '/cities/:id' do
    city = City.find(params[:id])
    city.update(params[:city])
    redirect "/cities/#{city.id}"
  end

  delete '/cities/:id' do
    City.destroy(params[:id])
    redirect "/cities"
  end

  get '/trips' do
    redirect "/trips/?page=1"
  end

  get '/trips/' do
    @stations = Station.all
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)
    erb :"/trips/index"
  end

  get '/trips/new' do
    @trips = Trip.all
    erb :"/trips/new"
  end

  post '/trips' do
    station1 = Station.find(params[:trip][:start_station_id])
    station2 = Station.find(params[:trip][:end_station_id])
    subscription = Subscription.find_by(name: params[:subscription][:name])
    trip = Trip.new(params[:trip])
    trip.start_station_id = station1.id
    trip.end_station_id = station2.id
    trip.subscription = subscription
    trip.save!
    redirect "/trips/#{trip.id}"
  end

  get '/trips/:id' do
    @trip = Trip.find(params[:id])
    @stations = Station.all
    erb :"/trips/show"
  end

  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    erb :"/trips/edit"
  end

  put '/trips/:id' do
    trip = Trip.find(params[:id])
    trip.update(params[:trip])
    redirect "/trips/#{trip.id}"
  end

  delete '/trips/:id' do
    Trip.destroy(params[:id])
    redirect '/trips'
  end

  get '/conditions' do
    redirect '/conditions/?page=1'
  end

  get '/conditions/' do
    @conditions = Condition.paginate(:page => params[:page], :per_page => 30)
    erb :"/conditions/index"
  end

  get '/conditions/new' do
    erb :"/conditions/new"
  end

  post '/conditions' do
    condition = Condition.create(params[:condition])
    redirect "/conditions/#{condition.id}"
  end

  get '/conditions/:id' do
    @condition = Condition.find(params[:id])
    erb :"/conditions/show"
  end

  get '/conditions/:id/edit' do
    @condition = Condition.find(params[:id])
    erb :"conditions/edit"
  end

  put '/conditions/:id' do
    condition = Condition.find(params[:id])
    condition.update(params[:condition])
    redirect "/conditions/#{condition.id}"
  end

  delete '/conditions/:id' do
    condition = Condition.find(params[:id])
    condition.destroy
    redirect "/conditions"
  end

  get '/trips-dashboard' do
    @trips = Trip.all
    erb :"/trips/dashboard"
  end

end
