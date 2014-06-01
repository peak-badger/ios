class MotivationScreen < BackgroundScreen

  MOTIVATIONAL_TEXTS = [
      'Get off your butt lazy!',
      'Don\'t you have some pounds to work off?',
      'No wonder you\'re still single!'
  ]

  self.image = 'off-peak.png'

  def will_appear
    set_attributes self.view, {styleId: 'motivation-screen'}
    self.view.addSubview background_image
    self.view.addSubview text
    self.view.addSubview motivate_button
    change_motivational_text
  end

  private

  def change_motivational_text
    text.text = MOTIVATIONAL_TEXTS.sample
  end

  def text
    @text ||= UILabel.new.tap do |text|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = view.frame.size.height
      top = view.frame.size.height / 3
      left = margin
      text.numberOfLines = 0
      text.lineBreakMode = NSLineBreakByWordWrapping
      text.styleClass = 'motivator'
      text.frame = [[left, top], [width, height]]
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