require('pg')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

attr_reader(:id)
attr_accessor(:name)


  def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists
      (
      name
      )
      VALUES
      (
      $1
      )
      RETURNING *"
      values = [@name]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def albums()
      sql = "SELECT * FROM album WHERE customer_id = $1 "
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map { |songs| Album.new(songs)}
    end


end
