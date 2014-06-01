module LocationHelper

  def poll_for_location
    block = proc { Tracker.update }
    block.call
    EM.add_periodic_timer 5.0 do
      block.call
    end
  end

  def fetch_location(&block)
    if Tracker.last.valid?
      block.call Tracker.last if block_given?
    else
      Tracker.update(&block)
    end
  end

end