desc "Starts the group service on port 9002"
task :start do
  exec "foreman start -p 9002"
end