class BackgroundScreen < PM::Screen

  class << self
    attr_accessor :image
  end

  private

  def background_image
    @background_image ||= begin
      image = UIImage.imageNamed self.class.image
      UIImageView.alloc.initWithImage(image).tap do |image|
        image.styleClass = 'background'
        width = view.frame.size.width
        height = view.frame.size.height
        top = 0
        left = 0
        image.frame = [[left, top], [width, height]]
      end
    end
  end

end