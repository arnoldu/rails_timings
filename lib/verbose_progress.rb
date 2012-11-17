#
# VerboseProgress
#
# implementiert einen intelligenten Fortschrittsbalken für langwierige Prozesse, die
# eine Bildschirmausgabe erfordern.
#
class VerboseProgress
  def initialize(txtprefix,maxval)
    @started = Time.now
    @maxval = (maxval>0 ? maxval : 1)
    @txtprefix = txtprefix
    @showeach = 0.015 #not more often than once a second
    @lastshowed = @started - @showeach
    print " "
    if block_given?
      yield(self) 
      fullstop
    end
  end
  
  def progress(thisval,txtsuffix="")
    tmpnow = Time.now
    if tmpnow > @lastshowed + @showeach
      numoutput = " #{thisval}/#{@maxval}"
      remainingtime = Time.at((tmpnow - @started)/thisval*(@maxval-thisval))
      blocks = [@txtprefix+txtsuffix,numoutput,remainingtime.strftime('%Mm %Ss')]
      print fillup("\x0d|#{fillup(blocks[0],45)}|#{fillup(blocks[1],14)}|#{fillup(blocks[2],12)}|",78)
      @lastshowed = tmpnow
    end
  end
  
  private
  
  def fullstop
    print fillup("\x0d#{@txtprefix} #{@maxval}/#{@maxval} benötigte #{Time.at(Time.now-@started).strftime('%Mm %Ss')}",78)+"\n"
  end
  
  def fillup(txt,nochar)
    if txt.size > nochar
      txt = txt[0..-4]+"..."
    else
      txt += " " * (nochar - txt.size)
    end
    return txt
  end
  
end
