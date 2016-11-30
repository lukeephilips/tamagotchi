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

# post('/interaction') do
#   interaction = params.fetch('interactions')
#    @all_tamagotchis = Tamagotchi.all()
#    @all_tamagotchis[0].tamagotchi_changes(@all_tamagotchis[0].time_passes())
#    if @all_tamagotchis[0].is_alive
#     if interaction == 'feed'
#       @all_tamagotchis[0].feed()
#     elsif interaction == 'pet'
#       @all_tamagotchis[0].pet()
#     elsif interaction == 'nap'
#       @all_tamagotchis[0].nap()
#     elsif interaction == 'clean'
#       @all_tamagotchis[0].clean()
#     end
#     erb(:interaction)
#   else
#     erb(:graveyard)
#   end
#   # else
#   #   erb(:graveyard)
# end

# get('/output/:id') do
#   @new_pet = Tamagotchi.find(params.fetch("id"))
#   erb(:output)
# end
