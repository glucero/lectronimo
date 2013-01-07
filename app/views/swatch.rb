class Swatch < UIView

  extend IB

  attr_accessor :color

  def drawRect(rect)
    unless color.nil?
      UIColor.alloc.initWithRed(color[:red].to_f / 255,
                                green: color[:green].to_f / 255,
                                blue: color[:blue].to_f / 255,
                                alpha: 1.0).set

      UIBezierPath.bezierPathWithRect(rect).fill
    end
  end

end
