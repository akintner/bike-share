class ConditionsApp < BikeShareApp

  get '/conditions' do
    @conditions = Condition.all.take(30)
    erb :"conditions/index"
  end
end
