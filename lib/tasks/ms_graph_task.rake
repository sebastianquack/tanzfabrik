require_relative '../../app/services/ms_graph'

desc 'imports calendar events to database'
task :run_ms_graph => :environment do
  
  # require "services/ms_graph"
  puts "Running task!!!"

  client_id = '7c7608bf-a091-4e6c-a5c1-301232ac6cb1'
  client_secret = '6nK8Q~9s22oDM3gh3.2C9O3PDTVqotYM5F76wb~-'
  scope = ['https://graph.microsoft.com/.default'] # Add any required scopes

  ms_graph_client = MsGraphClient.new(client_id, client_secret, scope)

  token = ms_graph_client.authenticate()
  puts(token)
end

