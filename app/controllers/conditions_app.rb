class ConditionsApp < BikeShareApp

  get '/conditions' do
    @conditions = Condition.all.take(30)
    erb :"conditions/index"
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
end
