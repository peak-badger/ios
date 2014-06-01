class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    extend LocationHelper
    Peak.load
    poll_for_location
    open HomeScreen.new(nav_bar: true)
  end

  def will_enter_foreground
    fetch_location
  end
  
end
