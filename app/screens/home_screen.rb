class HomeScreen < PM::Screen
  include LocationHelper

  title "Peak Badger"

  def will_appear
    set_attributes self.view, {styleId: 'main-view'}
    self.view.addSubview check_in_button
  end

  def attempt_checkin
    fetch_location do |location|
      get_peak_badge location.peak
    end
  end

  def show_invalid_peak!
    App.alert("You are not on a Peak!!!")
  end

  def get_peak_badge(peak)
    return show_invalid_peak! if peak.nil?
    App.alert("You have checked into #{peak.name}")
  end

  private

  def check_in_button
    @check_in_button ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 40
      top = view.frame.size.height - height - margin
      left = margin
      button.setTitle "Check In", forState: UIControlStateNormal
      button.frame = [[left, top],[width, height]]
      button.styleId = 'check-in-button'
      button.when(UIControlEventTouchUpInside) { attempt_checkin }
    end

  end
end
