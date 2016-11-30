class Tamagotchi
  @@all_tamagotchis = []
  @@live_tamagotchis = []
  @@dead_tamagotchis = []

  define_method(:initialize) do |name, species|
    @name = name
    @species = species
    @food = 100
    @rest = 100
    @love = 100
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
    @food > 0 and @rest > 0 and @love > 0 and @poop < 100
  end
  define_method(:set_food) do |level|
    @food = level
  end

  define_method(:time_passes) do
    right_now = Time.new()
    difference = right_now - @start_time
  end
  define_method(:tamagotchi_changes) do |time|
    @food -= (time/1.2).to_i
    @rest -= (time/1.5).to_i
    @love -= (time/2).to_i
    @poop += (time).to_i
    @start_time = Time.new()
  end

  define_method(:feed) do
    if @food < 125
      @food += 2
    end
  end
  define_method(:nap) do
    if @rest < 1125
      @rest += 3
    end
  end
  define_method(:pet) do
    if @love < 125
      @love += 4
    end
  end
  define_method(:clean) do
    if @poop > 0
      @poop -=5
    end
  end
  define_method(:kill) do
    @love -= 125
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
