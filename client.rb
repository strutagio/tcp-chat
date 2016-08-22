require "socket"

class Client

  def initialize server
    @server = server
    @request = nil
    @response = nil
    listen
    send
    @request.join
    @response.join
  end

  def send
    @request = Thread.new do
      loop {
        msg = $stdin.gets.chomp
        @server.puts(msg)
      }
    end
  end

  def listen
    @response = Thread.new do
      loop {
        msg = @server.gets.chomp
        puts "#{msg}"
      }
    end
  end

end

server = TCPSocket.open "52.40.37.103", 3000
Client.new (server)