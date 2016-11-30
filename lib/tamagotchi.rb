class Tamagotchi
  @@all_tamagotchis = []
  @@live_tamagotchis = []
  @@dead_tamagotchis = []

  define_method(:initialize) do |name, species|
    @name = name
    @species = species
    @food = 10
    @rest = 10
    @love = 10
    @poop = 0
    @start_time = Time.new()
    @id = @@all_tamagotchis.length().+(1)
    @image = image(species)
  end

  define_method(:id) do
    @id
  end
  define_method(:image) do
    @image
  end
  define_singleton_method(:all) do
    @@all_tamagotchis
  end
  define_singleton_method(:live) do
    @@live_tamagotchis
  end
  define_singleton_method(:dead) do
    @@dead_tamagotchis
  end
  define_method(:name) do
    @name
  end
  define_method(:species) do
    @species
  end
  define_method(:food) do
    @food
  end
  define_method(:rest) do
    @rest
  end
  define_method(:love) do
    @love
  end
  define_method(:poop) do
    @poop
  end

  define_method(:is_alive) do
    @food > 0 and @rest > 0 and @love > 0 and @poop < 10
  end
  define_method(:set_food) do |level|
    @food = level
  end

  define_method(:time_passes) do
    right_now = Time.new()
    difference = right_now.min - @start_time.min
  end
  define_method(:tamagotchi_changes) do |time|
    @food -= time
    @rest -= time
    @love -= time * 0.5
    @poop += time * 2
    @start_time = Time.new()
  end

  define_method(:feed) do
    @food += 1
  end
  define_method(:nap) do
    @rest += 1
  end
  define_method(:pet) do
    @love += 1
  end
  define_method(:clean) do
    @poop -= 2
  end
  define_method(:kill) do
    @love -= 10
  end

  define_method(:save) do
    @@all_tamagotchis.push(self)
    @@live_tamagotchis.push(self)

  end
  define_method(:dies) do
    @@live_tamagotchis.delete(self)
    @@dead_tamagotchis.push(self)
  end
  define_singleton_method(:clear) do
    @@all_tamagotchis = []
  end

  define_singleton_method(:find) do |identification|
    found_tomagotchi = nil
    @@all_tamagotchis.each() do |pet|
      if pet.id.eql?(identification.to_i)
        found_tomagotchi = pet
      end
    end
    found_tomagotchi
  end
  define_method(:image) do |animal|
    images = {'Fluffy Bunny' => '../img/bunny.gif', 'Scary Tiger' => '../img/tiger.gif', 'Awkward Turtle' => '../img/turtle.gif', 'Waffle' => '../img/waffle.jpeg'}
    images[animal]
  end
end
