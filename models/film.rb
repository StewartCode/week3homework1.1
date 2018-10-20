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

  #display all the stars for a particular movie

  def customers()
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON customers.id = tickets.customer_id
           WHERE film_id = $1"
    values = [@id]
    star_data = SqlRunner.run(sql, values)
    return Star.map_items(star_data)
  end

  # extension

  def tickets()
    sql = "SELECT *
           FROM tickets
           WHERE movie_id = $1"
    values = [@id]
    t_data = SqlRunner.run(sql, values)
    return t_data.map{|t| Ticket.new(t)}
  end

  # def remaining_budget()
  #   tickets = self.tickets()
  #   casting_fees = castings.map{|casting| casting.fee}
  #   combined_fees = casting_fees.sum
  #   return @budget - combined_fees
  # end
  def customers()
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON customers.id = tickets.customer_id
           WHERE film_id = $1"
    values = [@id]
    f_data = SqlRunner.run(sql, values)
    return Customer.map_items(f_data)
  end

  def self.all()
    sql = "SELECT * FROM films"
    f = SqlRunner.run(sql)
    return Film.map_items(f)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|movie| Film.new(movie)}
    return result
  end

end
