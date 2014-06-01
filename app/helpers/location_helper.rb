module LocationHelper

  def poll_for_location
    proc { Tracker.update }.tap do |block|
      block.call
      EM.add_periodic_timer 5.0 do
        block.call
      end
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