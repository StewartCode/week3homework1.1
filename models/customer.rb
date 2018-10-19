require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
          (name,
           funds
          )
           VALUES ($1, $2)
           RETURNING id"
    values = [@name, @funds]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def update()
    sql = "UPDATE customers
           SET (name,
               funds
               )
               = ($1, $2)
           WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * from customers
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  #
  # # display all the movies a particular star is cast in
  #
  # def movies()
  #   sql = "SELECT movies.*
  #          FROM movies
  #          INNER JOIN castings
  #          ON movies.id = castings.movie_id
  #          WHERE star_id = $1"
  #   values = [@id]
  #   movie_data = SqlRunner.run(sql, values)
  #   return Movie.map_items(movie_data)
  # end
  #
  def self.all()
    sql = "SELECT * FROM customers"
    star_data = SqlRunner.run(sql)
    return Star.map_items(star_data)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  # def self.map_items(data)
  #   result = data.map{|star| Star.new(star)}
  #   return result
  # end

end
