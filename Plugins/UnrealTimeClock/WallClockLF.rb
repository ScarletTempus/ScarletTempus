#===============================================================================
# * Wall Clock - by FL (Credits will be apreciated)
#===============================================================================
#
# This script is for Pokémon Essentials. It's the Wall Clock from
# Ruby/Sapphire/Emerald.
#
#== INSTALLATION ===============================================================
#
# Put it above main OR convert into a plugin. Create "Wall Clock" folder at 
# Graphics/Pictures and put the pictures:
# -  56x24  am
# - 256x256 clock_female
# - 256x256 clock_male
# -  56x24  pm
# -  24x100 pointer_hour
# -  24x100 pointer_minute
#
#== HOW TO USE =================================================================
#
# Call:
# - 'display_wall_clock(true)' for boy clock.
# - 'display_wall_clock(false)' for girl clock.
# - 'display_wall_clock($player.gender==0)' for clock of the player gender.
# - 'display_wall_clock($Trainer.gender!=0)' for clock of the opposite of player
# gender.
#
# Use $Trainer instead of $player on Essentials v19.1 and lower.
#
#===============================================================================

if defined?(PluginManager) && !PluginManager.installed?("Wall Clock")
  PluginManager.register({                                                 
    :name    => "Wall Clock",                                        
    :version => "1.0.1",                                                     
    :link    => "https://www.pokecommunity.com/showthread.php?t=333511",
    :credits => "FL"
  })
end

class WallClockScene
  IMAGE_PATH="Graphics/Pictures/Wall Clock/"
  
  def start_scene(male)
    @sprites={} 
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["background"]=IconSprite.new(0,0,@viewport)
    @sprites["background"].bitmap=Bitmap.new(Graphics.width,Graphics.height)
    @sprites["background"].bitmap.fill_rect(
      0,
      0,
      @sprites["background"].bitmap.width, 
      @sprites["background"].bitmap.height,
      Color.new(72,176,184)
    )
    @sprites["clock"]=IconSprite.new(0,0,@viewport)
    @sprites["clock"].setBitmap(
      IMAGE_PATH + (male ? "clock_male" : "clock_female")
    )
    @sprites["clock"].x = (Graphics.width - @sprites["clock"].bitmap.width)/2
    @sprites["clock"].y = (Graphics.height - @sprites["clock"].bitmap.height)/2
    @sprites["pointerminute"]=IconSprite.new(0,0,@viewport)
    @sprites["pointerminute"].setBitmap(IMAGE_PATH + "pointer_minute")
    @sprites["pointerminute"].x = @sprites["clock"].x + 128
    @sprites["pointerminute"].y = @sprites["clock"].y + 128
    @sprites["pointerminute"].ox = 12
    @sprites["pointerminute"].oy = 88
    @sprites["pointerhour"]=IconSprite.new(0,0,@viewport)
    @sprites["pointerhour"].setBitmap(IMAGE_PATH + "pointer_hour")
    @sprites["pointerhour"].x = @sprites["clock"].x + 128
    @sprites["pointerhour"].y = @sprites["clock"].y + 128
    @sprites["pointerhour"].ox = 12
    @sprites["pointerhour"].oy = 88
    update_clock(pbGetTimeNow)
    pbFadeInAndShow(@sprites) { update }
  end

  def update
    pbUpdateSpriteHash(@sprites)
  end
  
  def update_clock(time)
    @sprites["pointerminute"].angle = -time.min*6
    @sprites["pointerhour"].angle = (-time.hour%12)*30 + (-time.min)/2
    @sprites["pmam"].dispose if @sprites["pmam"]
    @sprites["pmam"] = IconSprite.new(0,0,@viewport)
    @sprites["pmam"].setBitmap(IMAGE_PATH + (time.hour>=12 ? "pm" : "am"))
    @sprites["pmam"].x = @sprites["clock"].x+(
        @sprites["clock"].bitmap.width - @sprites["pmam"].bitmap.width
    )/2
    @sprites["pmam"].y = @sprites["clock"].y+176
  end  

  def main
    seconds_for_update = 5
    loop do
      Graphics.update
      Input.update
      if Graphics.frame_count % (seconds_for_update*Graphics.frame_rate)==0
        update_clock(pbGetTimeNow)
      end
      update
      if Input.trigger?(Input::C) || Input.trigger?(Input::B)
        pbPlayDecisionSE
        break
      end   
    end 
  end

  def end_scene
    pbFadeOutAndHide(@sprites) { update }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

class WallClockScreen
  def initialize(scene)
    @scene=scene
  end

  def start_screen(male)
    @scene.start_scene(male)
    @scene.main
    @scene.end_scene
  end
end

def display_wall_clock(male = true)
  pbFadeOutIn(99999) {
    scene=WallClockScene.new
    screen=WallClockScreen.new(scene)
    screen.start_screen(male)
  }
end