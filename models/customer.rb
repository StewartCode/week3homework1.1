require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
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

  # display all the films a particular customer is booked in

  def films()
    sql = "SELECT films.*
           FROM films
           INNER JOIN tickets
           ON films.id = tickets.film_id
           WHERE customer_id = $1"
    values = [@id]
    f_data = SqlRunner.run(sql, values)
    return Film.map_items(f_data)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|star| Customer.new(star)}
    return result
  end

end
