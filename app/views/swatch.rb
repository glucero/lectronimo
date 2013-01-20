class Swatch < UIView

  extend IB

  attr_accessor :color

  def drawRect(rect)
    unless color.nil?
      UIColor.alloc.initWithRed(color[:red],
                                green: color[:green],
                                blue: color[:blue],
                                alpha: 1.0).set

      UIBezierPath.bezierPathWithRect(rect).fill
    end
  end

end
