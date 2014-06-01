class MotivationScreen < BackgroundScreen

  self.image = 'off-peak.png'

  def will_appear
    set_attributes self.view, {styleId: 'motivation-screen'}
    self.view.addSubview background_image
    self.view.addSubview text
    self.view.addSubview motivate_button
    change_motivational_text
  end

  private

  def motivations
    @motivations ||= File.read(File.join App.resources_path, 'motivation.txt').lines.to_a.map do |quote|
      quote.split('–').map(&:strip).join("\n\n")
    end
  end

  def change_motivational_text
    text.text = motivations.sample
  end

  def text
    @text ||= UILabel.new.tap do |text|
      margin = 20
      width = view.frame.size.width - margin * 2
      height = view.frame.size.height
      top = 0
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