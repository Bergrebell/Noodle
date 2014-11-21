# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

family = User.create([{ :username => 'Rudi', :email => 'rtest@test.de', :password => '12345' }, { :username => 'Nic', :email => 'nic.spycher@gmail.com', :password => '12n12s' }, {:username => 'Karin', :email => 'ktest@test.de', :password => '12345'}, {:username => 'Leonie', :email => 'ltest@test.de', :password => '12345'}, {:username => 'Carolin', :email => 'ctest@test.de', :password => '12345'} ])

