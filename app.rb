require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/tamagotchi')

get('/') do
  erb(:index)
end

get('/tamagotchis') do
  @all_tamagotchis = Tamagotchi.all()
  @all_tamagotchis.each do |pet|
    if !pet.is_alive
      pet.dies
    end
  end
  @live_tamagotchis = Tamagotchi.live()
  erb(:tamagotchis)
end

get('/tamagotchi/new') do
  erb(:tamagotchi_form)
end

post('/tamagotchis') do
  @name = params.fetch('pet_name')
  @species = params.fetch('species')
  new_pet = Tamagotchi.new(@name, @species)
  new_pet.save()
  erb(:success)
end

get('/tamagotchis/:id') do
  @tamagotchi = Tamagotchi.find(params.fetch('id'))
  @pic = @tamagotchi.image(@tamagotchi.species)
  @tamagotchi.tamagotchi_changes(@tamagotchi.time_passes())
  if @tamagotchi.is_alive
    erb(:tamagotchi)
  else
    @tamagotchi.dies()
    @dead_tamagotchis = Tamagotchi.dead()
    erb(:graveyard)
  end
end

post('/tamagotchis/:id') do
  @tamagotchi = Tamagotchi.find(params.fetch('id'))
  @pic = @tamagotchi.image(@tamagotchi.species)
  @tamagotchi.tamagotchi_changes(@tamagotchi.time_passes())
  interaction = params.fetch('interactions')
  @tamagotchi.send(interaction)
  if @tamagotchi.is_alive

    erb(:tamagotchi)
  else
    @tamagotchi.dies()
    @dead_tamagotchis = Tamagotchi.dead()
    @dead_tamagotchis = Tamagotchi.dead()
    erb(:graveyard)
  end
end

get('/graveyard') do
  @dead_tamagotchis = Tamagotchi.dead()
  erb(:graveyard)
end
