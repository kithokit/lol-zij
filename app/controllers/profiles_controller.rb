require 'lol'
class ProfilesController < ApplicationController

  def index
    default_players
    render "index"
  end

  def search
    @profile = Profile.new(:name => params["q"])
    render "index"
  end


  def default_players
    players = ["kithokit", "ringopak", "Team Cap", "yamsaihoi"]
    @profiles = []
    players.each { |p|
      profile = Profile.new(:name => p)
      @profiles << profile
    }
    @profiles
  end
end
