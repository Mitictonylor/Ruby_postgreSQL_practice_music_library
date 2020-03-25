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
end
