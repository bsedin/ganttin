Rails.application.config.middleware.use(Rack::Config) do |env|
  env['api.tilt.root'] = File.join(Ganttin::Environment.root, 'app', 'views', 'ganttin', 'api')
end
