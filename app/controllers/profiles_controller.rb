require 'lol'
class ProfilesController < ApplicationController

  def index
    @profile = Profile.new( :name => "kithokit")
    @statsconnection.stats.summary(@profile.summonerid)
    @win = @stats.detect { |a| a.player_stat_summary_type == "RankedSolo5x5" }.wins
    @losses = @stats.detect { |a| a.player_stat_summary_type == "RankedSolo5x5" }.losses
  end
end
