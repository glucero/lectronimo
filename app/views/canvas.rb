class Canvas < UIView

  extend IB

  def drawRect(rect)
    App.delegate.lectronimo.each_path do |color, line|
      color.set and line.stroke
    end
  end

end
