class HomeScreen < PM::Screen
  title "Peak Badger"

  def will_appear
    margin = 20
    set_attributes self.view, {
        styleId: 'main-view'
    }
    @checkInButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.setTitle "Check In", forState: UIControlStateNormal
      button.frame = [
          [margin, view.frame.size.height / 2 - margin],
          [view.frame.size.width - margin * 2, 40]
      ]
      button.styleId = 'check-in-button'
      button.when(UIControlEventTouchUpInside) do
        attempt_checkin
      end
      self.view.addSubview button
    end
  end

  def attempt_checkin
    BW::Location.get_once do |location|
      get_peak_badge Peak.all.find { |peak| peak.nearby?(location) }
    end
  end

  def show_invalid_peak!
    App.alert("You are not on a Peak!!!")
  end

  def get_peak_badge(peak)
    return show_invalid_peak! if peak.nil?
    App.alert("You have checked into #{peak.name}")
  end

end
