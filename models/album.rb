require_relative('../db/sql_runner')
require_relative('./artist.rb')

class Album
attr_accessor :title, :genre, :artist_id
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1,$2,$3) RETURNING *"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql,values)[0]["id"].to_i
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    array_of_albums = SqlRunner.run(sql, [])
    return array_of_albums.map {|album| Album.new(album)}
  end

  def Album.find_album_by_artist(artist_id)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist_id]
    album_hash = SqlRunner.run(sql,values).first
    return Album.new(album_hash)
  end

  def update()
    sql = " UPDATE albums SET (album_id,title,genre) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@album_id, @title, @genre, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def Album.find_by_id(id)
    sql= "SELECT * FROM albums WHERE id = $1"
    values = [id]
    album = SqlRunner.run(sql,values)
    return Album.new(album.first)
  end

  def get_artist()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run( sql,values )
    result = Artist.new( artist.first )
    return result
  end




end
