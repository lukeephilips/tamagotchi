require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/tamagotchi')

get('/') do
  erb(:index)
end

get('/tamagotchis') do
  @all_tamagotchis = Tamagotchi.all()
  erb(:tamagotchis)
end

get('/tamagotchi/new') do
  erb(:tamagotchi_form)
end

post('/tamagotchis') do
  name = params.fetch('pet_name')
  species = params.fetch('species')
  new_pet = Tamagotchi.new(name, species)
  new_pet.save()
  erb(:success)
end

get('/tamagotchis/:id') do
  @tamagotchi = Tamagotchi.find(params.fetch('id'))
  erb(:tamagotchi)
end

post('/tamagotchis/:id') do
  @tamagotchi = Tamagotchi.find(params.fetch('id'))
  interaction = params.fetch('interactions')
   @tamagotchi.tamagotchi_changes(@tamagotchi.time_passes())
   if @tamagotchi.is_alive
    if interaction == 'feed'
      @tamagotchi.feed()
    elsif interaction == 'pet'
      @tamagotchi.pet()
    elsif interaction == 'nap'
      @tamagotchi.nap()
    elsif interaction == 'clean'
      @tamagotchi.clean()
    end
    erb(:interaction)
  else
    erb(:graveyard)
  end
end

get('/interaction') do
  erb(:tamagotchi)
end
