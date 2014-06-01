class CheckInScreen < BackgroundScreen
  include LocationHelper

  self.image = 'on-peak.png'
  title "Peak Badger"

  def will_appear
    set_attributes self.view, {styleId: 'check-in-screen'}
    self.view.addSubview background_image
    self.view.addSubview check_in_button
    self.view.addSubview text
    self.view.addSubview peak_name
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
    return show_invalid_peak! unless peak.valid?
    App.alert("You have checked into #{peak.name}")
  end

  private

  def text
    @text ||= UILabel.new.tap do |text|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 40
      top = 200
      left = margin
      text.numberOfLines = 0
      text.lineBreakMode = NSLineBreakByWordWrapping
      text.styleClass = 'info'
      text.frame = [[left, top], [width, height]]
      text.text = "Great job, it looks like you reached the top of"
    end
  end

  def peak_name
    @peak_name ||= UILabel.new.tap do |text|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 40
      top = 0
      left = margin
      text.numberOfLines = 0
      text.lineBreakMode = NSLineBreakByWordWrapping
      text.styleClass = 'peak-name'
      text.frame = [[left, top], [width, height]]
      text.text = LocationHelper::Tracker.last.peak.name
    end
  end

  def check_in_button
    @check_in_button ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 40
      top = view.frame.size.height - height - margin
      left = margin
      button.setTitle 'Get your badge', forState: UIControlStateNormal
      button.frame = [[left, top], [width, height]]
      button.styleId = 'check-in-button'
      button.when(UIControlEventTouchUpInside) { attempt_checkin }
    end
  end

end
