require_relative('models/ticket')
require_relative('models/film')
require_relative('models/customer')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


  film1 = Film.new({
    'title' => 'man_bites_dog',
    'price' => 8
  })

  film1.save()

  film2 = Film.new({
    'title' => 'operation wolf',
    'price' =>  5
  })

  film2.save()

  film3 = Film.new({
    'title' => 'pans labyrinth',
    'price' =>  6
  })

  film3.save()

  film4 = Film.new({
    'title' => 'ghost busters',
    'price' =>  4
  })

  film4.save()

#________________________________________

  customer1 = Customer.new({
    'name' => 'bob smith',
    'funds' => 20
  })

  customer1.save()


  customer2 = Customer.new({
    'name' => 'jim hunter',
    'funds' => 40
  })

  customer2.save()

  customer3 = Customer.new({
    'name' => 'gareth miles',
    'funds' => 120
  })

  customer3.save()

  customer4 = Customer.new({
    'name' => 'jimmy cranky',
    'funds' => 39
  })

  customer4.save()

  ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id})
  ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer2.id})
  ticket3 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer3.id})
  ticket4 = Ticket.new({'film_id' => film4.id, 'customer_id' => customer4.id})
  ticket5 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer1.id})
  ticket6 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer2.id})


 ticket1.save()
 ticket2.save()
 ticket3.save()
 ticket4.save()
 ticket5.save()
 ticket6.save()

 Ticket.all()
 Film.all()
 Customer.all()

 customer1.films

 film2.customers

 # customer1.name = "test name"
 # customer1.update

 # film1.title = "test name"
 # film1.update

binding.pry
nil
