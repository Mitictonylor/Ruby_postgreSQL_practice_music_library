require_relative("../db/sql_runner")

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(option)
    @id = option['id'].to_i if option['id']
    @name = option['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql,values)[0]["id"].to_i
  end

  def Artist.all()
    sql = "SELECT * FROM artists"
    array_of_artists = SqlRunner.run(sql, [])
    return array_of_artists.map {|artist| Artist.new(artist)}
  end

  def Artist.find_artist_by_album(album_id)
    sql= "SELECT artist_id FROM albums WHERE id = $1"
    values = [album_id]
    # orders = SqlRunner.run(sql,values)
    orders = SqlRunner.run(sql,values)[0]["artist_id"]
    return orders
    # .map{|artist| Album.new(artist)}
  end

  def update()
    sql = " UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def Artist.find_by_id(id)
    sql= "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql,values).first
    return Artist.new(artist)
  end
end
