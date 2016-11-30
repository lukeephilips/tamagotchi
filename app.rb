require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/tamagotchi')

get('/') do
  erb(:index)
end

get('/tamagotchis') do
  @all_tamagotchis = Tamagotchi.all()
  @live_tamagotchis = Tamagotchi.live()
  # @dead_tamagotchis = Tamagotchi.dead()


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
  erb(:tamagotchi)
end

post('/tamagotchis/:id') do
  @tamagotchi = Tamagotchi.find(params.fetch('id'))
  interaction = params.fetch('interactions')
  if @tamagotchi.is_alive
 @tamagotchi.tamagotchi_changes(@tamagotchi.time_passes())
    if interaction == 'feed'
      @tamagotchi.feed()
    elsif interaction == 'pet'
      @tamagotchi.pet()
    elsif interaction == 'nap'
      @tamagotchi.nap()
    elsif interaction == 'clean'
      @tamagotchi.clean()
    elsif interaction == 'kill'
      @tamagotchi.kill()
    end
    erb(:tamagotchi)
  else
    @tamagotchi.dies()
    # @dead_tamagotchis = Tamagotchi.dead()
    # @dead_tamagotchis.push(@tamagotchi)
    erb(:graveyard)
  end
end

get('/graveyard') do
  @dead_tamagotchis = Tamagotchi.dead()
  erb(:graveyard)
end
get('/interaction') do
  erb(:tamagotchi)
end
