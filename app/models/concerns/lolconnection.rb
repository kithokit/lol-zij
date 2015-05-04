class LolConnection

  API_KEY="1948f104-b8fb-4787-894f-79821a2d45b0"

  def connection
    if @connection.nil?
      @connection =  Lol::Client.new API_KEY, {
        region: "na",
        redis: "redis://localhost:6379",
        ttl: 900
      }
    end

    @connection
  end

end
