class Profile < ActiveRecord::Base
  include lolconnection
  attr_accessor :summonerid
  attr_accessor :name

  def summonerid
    @name || connection.summoner.by_name(self.name).id
  end
end
