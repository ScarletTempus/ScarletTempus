class Player
  attr_accessor :charmsActive
  attr_accessor :eleCharmsActive
  attr_accessor :charmlist
  attr_accessor :elementCharmlist
  attr_accessor :last_wish_time
  attr_accessor :link_charm_data
  attr_accessor :ball_for_apricorn
  attr_accessor :next_run
	def initializeCharms
	@last_wish_time ||= 0
	@link_charm_data ||= [0, 0, []] #Species, Chain Count. 
	@ball_for_apricorn ||= 0
	@next_run ||= 0
    @charmlist ||= []
    @elementCharmList ||= []
	@active_count ||= 0
	@charmsActive = {
		:APRICORNCHARM	  => false,
		:BALANCECHARM     => false,
		:BERRYCHARM       => false,
		:CATCHINGCHARM    => false,
		:CLOVERCHARM      => false,
		:COINCHARM        => false,
		:CONTESTCHARM	  => false,
		:CORRUPTCHARM	  => false,
		:DISABLECHARM     => false,
		:EASYCHARM		  => false,
		:EFFORTCHARM	  => false,
		:EXPALLCHARM	  => false,
		:EXPCHARM         => false,
	    :FRUGALCHARM      => false,
		:GENECHARM		  => false,
		:GOLDCHARM        => false,
		:HARDCHARM		  => false,
		:HEALINGCHARM     => false,
		:HEARTCHARM       => false,
		:IVCHARM          => false,
		:KEYCHARM         => false,
		:LINKCHARM		  => false,
		:LURECHARM        => false,
		:MERCYCHARM       => false,
		:MININGCHARM      => false,
		:OVALCHARM        => false,
		:POINTSCHARM	  => false,
		:PROMOCHARM       => false,
		:PURIFYCHARM	  => false,
		:RESISTORCHARM	  => false,
		:ROAMINGCHARM	  => false,
		:SAFARICHARM	  => false,
		:SHINYCHARM       => false,
		:SLOTSCHARM       => false,
		:SMARTCHARM		  => false,
		:SPIRITCHARM      => false,
		:STABCHARM		  => false,
		:STEPCHARM		  => false,
		:TRADINGCHARM	  => false,
		:TRIPTRIADCHARM   => false,
		:TWINCHARM        => false,
		:VIRALCHARM       => false,
		:WISHINGCHARM     => false,

	:BUGCHARM         => false,
    :DARKCHARM        => false,
	:DRAGONCHARM      => false,
	:ELECTRICCHARM    => false,
	:FAIRYCHARM       => false,
    :FIGHTINGCHARM    => false,
	:FIRECHARM        => false,
	:FLYINGCHARM      => false,
    :GHOSTCHARM       => false,
    :GRASSCHARM       => false,
    :GROUNDCHARM      => false,
	:ICECHARM         => false,
	:NORMALCHARM      => false,
    :PSYCHICCHARM     => false,
    :POISONCHARM      => false,
    :ROCKCHARM        => false,
    :STEELCHARM       => false,
	:WATERCHARM       => false
		}
	end
end

module GameData
  class Item
    def is_charm?
      charm_ids = [
        :APRICORNCHARM, :BALANCECHARM, :BERRYCHARM,  :CLOVERCHARM, :COINCHARM,   :CONTESTCHARM, :CORRUPTCHARM,     :DISABLECHARM, :EFFORTCHARM,  :EASYCHARM,   
		:EXPALLCHARM,   :EXPCHARM,     :FRUGALCHARM, :GENECHARM,   :GOLDCHARM,   :HARDCHARM,    :HEALINGCHARM,   :HEARTCHARM,     :IVCHARM,      :KEYCHARM,     :LINKCHARM,   
		:LURECHARM,   	:MERCYCHARM,   :MININGCHARM, :OVALCHARM,   :POINTSCHARM, :PROMOCHARM,   :PURIFYCHARM,    :RESISTORCHARM,  :ROAMINGCHARM, :SAFARICHARM,  :SHINYCHARM,   
		:SLOTSCHARM,   	:SMARTCHARM,   :SPIRITCHARM, :STABCHARM,   :STEPCHARM,   :TRADINGCHARM, :TRIPTRIADCHARM, :TWINCHARM,      :VIRALCHARM,   :WISHINGCHARM
      ]
      charm = charm_ids.include?(self.id.to_sym)
      return charm
    end
	def is_echarm?
	echarm_ids = [
	    :BUGCHARM, 		:DARKCHARM,  :DRAGONCHARM, :ELECTRICCHARM, :FAIRYCHARM,
        :FIGHTINGCHARM, :FIRECHARM,  :FLYINGCHARM, :GHOSTCHARM,    :GRASSCHARM,
        :GROUNDCHARM,	:ICECHARM, 	 :NORMALCHARM, :PSYCHICCHARM,  :POISONCHARM,
        :ROCKCHARM, 	:STEELCHARM, :WATERCHARM
	]
	echarm = echarm_ids.include?(self.id.to_sym)
	return echarm
	end
  end
end