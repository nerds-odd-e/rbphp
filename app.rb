require 'sinatra'
require './person'

configure do
  set :bind, "0.0.0.0"
end

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
    redirect_with_message 'Name is required'
  end

  if person.name.length > 20
    redirect_with_message 'Name is too long'
  end

  if !person.name.match('^[a-z,A-Z]')
    redirect_with_message 'Name should start with alphabet'
  end

  existingPersons = @persons.select {|existing| existing.name == person.name}
  if existingPersons.length > 0
    redirect_with_message 'Name should not be duplicated'
  end
 
  @persons.push(person)
  redirect to('/list')
end

get '/list' do
  @persons = settings.persons
  erb :list
end

def redirect_with_message message
  redirect to "/?result=#{message}"
end
