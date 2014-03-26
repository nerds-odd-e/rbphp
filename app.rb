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
    redirect_with_message 'Name is required'
  end

  if person.name.length > 20
    redirect_with_message 'Name is too long'
  end

  if !person.name.match('^[a-z,A-Z]')
    redirect_with_message 'Name should start with alphabet'
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
