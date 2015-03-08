require 'sinatra'
require 'sinatra/reloader'

require 'fileutils'
require 'json'

require './uploaded_file.rb'


UploadedFile.from = File.expand_path('./uploaded/')
FileUtils.mkdir_p(UploadedFile.from)

set :port, 5555

post '/upload' do
  result = UploadedFile.new(request.env['rack.request.form_hash']['upload_file']).move
  if result[:result] == 'ok'
    status 201
  else
    status 500
  end
  
  result.to_json
end


