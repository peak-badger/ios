class MotivationScreen < BackgroundScreen
  include LocationHelper

  self.image = 'off-peak.png'

  def nearest_peak
    last_location.nearest_peak
  end

  def will_appear
    set_attributes self.view, {styleId: 'motivation-screen'}
    self.view.addSubview background_image
    self.view.addSubview motivational_text
    self.view.addSubview nearest_peak_text
    self.view.addSubview motivate_button
    change_motivational_text
    nearest_peak_text.text = "Get hiking!\n#{nearest_peak.name} is only #{nearest_peak.distance_with_units} away"
  end

  private

  def motivations
    @motivations ||= File.read(File.join App.resources_path, 'motivation.txt').lines.to_a.map do |quote|
      quote.split('–').map(&:strip).join("\n\n").strip
    end
  end

  def change_motivational_text
    motivational_text.text = motivations.sample
    margin = 20
    width = view.frame.size.width - margin * 2
    top = 0
    left = margin
    motivational_text.sizeToFit
    motivational_text.frame = [[left, top], [width, motivational_text.frame.size.height]]
  end

  def nearest_peak_text
    @nearest_peak_text ||= UILabel.new.tap do |text|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 0
      top = 0
      left = margin
      text.numberOfLines = 0
      text.lineBreakMode = NSLineBreakByWordWrapping
      text.styleClass = 'nearest-peak-text'
      text.frame = [[left, top], [width, height]]
    end
  end

  def motivational_text
    @motivational_text ||= UILabel.new.tap do |text|
      text.numberOfLines = 0
      text.lineBreakMode = NSLineBreakByWordWrapping
      text.styleClass = 'motivational-text'
    end
  end

  def motivate_button
    @motivate_button ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 40
      top = view.frame.size.height - height - margin
      left = margin
      button.setTitle 'Motivate Me', forState: UIControlStateNormal
      button.frame = [[left, top], [width, height]]
      button.styleId = 'check-in-button'
      button.when(UIControlEventTouchUpInside) { change_motivational_text }
    end
  end

end