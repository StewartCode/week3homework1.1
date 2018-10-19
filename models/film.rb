require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
          (title,
           price
          )
           VALUES
          ($1, $2)
           RETURNING id"
    values = [@title, @price]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def update()
    sql = "UPDATE films
           SET (title, price)
           = ($1, $2)
           WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE *
           FROM films
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # display all the stars for a particular movie

  # def stars()
  #   sql = "SELECT stars.*
  #          FROM stars
  #          INNER JOIN castings
  #          ON stars.id = castings.star_id
  #          WHERE movie_id = $1"
  #   values = [@id]
  #   star_data = SqlRunner.run(sql, values)
  #   return Star.map_items(star_data)
  # end
  #
  # # extension
  #
  # def castings()
  #   sql = "SELECT *
  #          FROM castings
  #          WHERE movie_id = $1"
  #   values = [@id]
  #   casting_data = SqlRunner.run(sql, values)
  #   return casting_data.map{|casting| Casting.new(casting)}
  # end
  #
  # def remaining_budget()
  #   castings = self.castings()
  #   casting_fees = castings.map{|casting| casting.fee}
  #   combined_fees = casting_fees.sum
  #   return @budget - combined_fees
  # end
  #
  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return Film.map_items(films)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  # def self.map_items(data)
  #   result = data.map{|movie| Movie.new(movie)}
  #   return result
  # end

end
