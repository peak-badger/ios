class NullScreen < BackgroundScreen
  include LocationHelper

  self.image = 'off-peak.png'

  def nearest_peak
    last_location.nearest_peak
  end

  def will_appear
    set_attributes self.view, {styleId: 'motivation-screen'}
    self.view.addSubview background_image
    self.view.addSubview null_text
  end

  private

  def null_text
    @null_text ||= UILabel.new.tap do |text|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = 0
      top = 0
      left = margin
      text.numberOfLines = 0
      text.lineBreakMode = NSLineBreakByWordWrapping
      text.styleClass = 'null-text'
      text.frame = [[left, top], [width, height]]
      text.text = "Gathering Information..."
    end
  end

end