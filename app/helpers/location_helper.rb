module LocationHelper

  def poll_for_location(&block)
    action = proc { Tracker.update(&block) }
    action.call
    EM.add_periodic_timer 5.0 do
      action.call
    end
  end

  def fetch_location(&block)
    if Tracker.last.valid?
      block.call Tracker.last if block_given?
    else
      Tracker.update(&block)
    end
  end

  def last_location
    Tracker.last
  end

end