class ApplicationController < Sinatra::Base
  # set :default_content_type, 'application/json'

  def json_response(code: 200, data: nil)
    status = [200, 201].include?(code) ? "SUCCESS" : "FAILED"
    headers['Content-Type'] = 'application/json'
    if data
      [ code, { data: data, message: status }.to_json ]
    end
  end

  # @api: Format all common JSON error responses
  def error_response(code, e)
    json_response(code: code, data: { error: e.message })
  end

  # @views: Format the erb responses
  def erb_response(file)
    headers['Content-Type'] = 'text/html'
    erb file
  end

  # @helper: not found error formatter
  def not_found_response
    json_response(code: 404, data: { error: "You seem lost. That route does not exist." })
  end

  # @api: 404 handler
  not_found do
    not_found_response
  end

  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

   # User routes
    
    # it works
    post '/users' do
      user_data = JSON.parse(request.body.read)
      user = User.find_by(phone: user_data['phone'])
      
      if user
        status 400
        body 'User already exists. Please login'
      else
        new_user = User.create(user_data)
        new_user.to_json
      end
    end
    

    post '/login' do
      phone = params[:phone]
      password = params[:password]
    
      user = User.find_by(phone: phone, password: password)
      if user
        { success: true, user: user }.to_json
      else
        { success: false, error: 'Invalid credentials' }.to_json
      end
    end
    
    
    
     
    

  # Pet routes
  # it works
  post '/pets/create' do
      begin
          new_pet = Pet.create(JSON.parse(request.body.read))
          json_response(code: 201, data: pet)
      rescue => e 
          json_response(code: 422, data: e.message)
      end 
  end

  # technically works
  get '/users/:user_id/pets' do
    user = User.find(params[:user_id])
    user.pets.to_json 
  end

  # it works
  get '/pets' do
    Pet.all.to_json
  end

  # it works
  post '/pets/search' do
      body = JSON.parse(request.body.read)
      pets = Pet.where('name LIKE ? OR breed LIKE ?', "%#{body['query']}%", "%#{body['query']}%")
      pets.to_json
  end

  # it works
  put '/update/pets/:id' do
      begin 
          data = JSON.parse(request.body.read)
          pet = Pet.find(params[:id])
          pet.update(data)
          pet.to_json
      rescue => e 
          { error: e.message}
      end 
  end

  # it works
  delete '/delete/pets/:id' do 
      begin
          # remove = JSON.parse(request.body.read) 
          pet = Pet.find(params[:id])
          pet.destroy
          "Deleted!"
          status 204

      rescue => e 
          { error: e.message}
      end 
  end

end
