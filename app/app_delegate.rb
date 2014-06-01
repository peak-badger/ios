class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    extend LocationHelper
    Peak.load
    will_enter_foreground
    poll_for_location { |l| location_handler l }
  end

  def will_enter_foreground
    fetch_location { |l| location_handler l }
  end

  def location_handler(location)
    if location.peak.valid?
      open CheckInScreen.new
    else
      open MotivationScreen.new
    end
  end

end
