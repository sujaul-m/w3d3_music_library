require('pg')
require_relative("../db/sql_runner.rb")
require_relative("album.rb")

class Artist

  attr_reader :id, :first_name, :last_name

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO artists
    (
      first_name,
      last_name
    ) VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums = results.map { |album| Album.new(album) }
    return albums
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist)}
  end


end
