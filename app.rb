require 'sinatra'
require './person'

set :persons, []

get '/' do
  erb :index
end

post '/' do
  @persons = settings.persons
  person = Person.new
  person.name = request["name"]
  person.title = request["title"]

  if person.name.empty?
    redirect to('/?result=Name is required')
  end

  @persons.push(person)
  redirect to('/list')
end

get '/list' do
  @persons = settings.persons
  erb :list
end