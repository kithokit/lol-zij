class Profile < ActiveRecord::Base

  include Lolconnection
  attr_accessor :summoner_id
  attr_accessor :name
  attr_accessor :stats
  attr_accessor :win
  attr_accessor :loss
  attr_accessor :winrate
  attr_accessor :tier
  attr_accessor :onfire

  def summoner_id
    @summoner_id || connection.summoner.by_name(self.name).first.id.to_s rescue nil
  end

  def leagueinfo
    if @leagueinfo.nil?
      @leagueinfo = connection.league.get(self.summoner_id)
      @leagueinfo = @leagueinfo[self.summoner_id].first
    end
    @leagueinfo
  end

  def infodetail
    if @infodetail.nil?
         @infodetail = leagueinfo.entries.detect { |a| a.player_or_team_id == self.summoner_id }
    end
    @infodetail
  end

  def tier
    if @tier.nil?
      tier = leagueinfo.tier
      division = infodetail.division
      @tier = tier + " " + division
    end
    @tier
  end

  def winrate
    unless win.nil? or loss.nil?
      (win.to_f/(win.to_f + loss.to_f)* 100).round(1)
    end
  end

  def stats
    @stats || connection.stats.summary(self.summoner_id)
  end

  def win
    @win || @infodetail.wins
  end

  def loss
    @loss = @infodetail.losses
  end

  def onfire
    @onfire = @infodetail.is_hot_streak
  end

end
