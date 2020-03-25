require("pry")
require_relative("../models/album")
require_relative("../models/artist")

artist1 = Artist.new({'name' => 'Sum 41'});

artist1.save()

album1 = Album.new({'title' => 'underclass hero',
                    'genre' => 'Punk rock',
                    'artist_id' => artist1.id
                   });
album1.save()
Artist.all()
binding.pry
nil
