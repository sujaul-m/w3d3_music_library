require("pry")
require_relative("../models/album.rb")
require_relative("../models/artist.rb")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'first_name' => 'Michael',
  'last_name' => 'Jackson'
  })

artist1.save()

album1 = Album.new ({
  'name' => 'Billie Jean',
  'genre' => 'Pop',
  'artist_id' => artist1.id
  })

album1.save()

binding.pry
nil
