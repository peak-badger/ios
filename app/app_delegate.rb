class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    extend LocationHelper
    Peak.import!
    fetch_location
    open HomeScreen.new(nav_bar: true)
  end
  
end
