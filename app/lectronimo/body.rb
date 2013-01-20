module Body

  def location
    @location ||= App.center
  end

  def visible?
    @visible
  end

  def show
    @visible = true
  end

  def hide
    @visible = false
  end

  def home
    heading 0.0
    xy App.center.to_a
  end

  def direction
    @heading
  end

  def heading(value)
    @heading = single(value)
  end

  def rotate(degrees)
    @heading += degrees
    @heading += 360.0 while direction < 0
    @heading -= 360.0 while direction >= 360
  end

  # orientation:
  # lectronimo  vs.  iphone
  #      2             -2
  #      1             -1
  # -2-1 0 1 2     -2-1 0 1 2
  #     -1              1
  #     -2              2
  def right(values) # turn left
    multiple(values).each { |degree| rotate(-degree) }
  end

  def left(values)  # turn right
    multiple(values).each { |degree| rotate(+degree) }
  end

  def destination(steps)
    { :sine   => location.x,
      :cosine => location.y }.map do |function, coordinate|

      heading  = @heading + 180.0
      heading -= 360.0 if direction >= 360
      heading *= degree
      offset   = send(function, heading)

      (offset * steps) + coordinate
    end
  end

  def face(coordinate)
    coordinate[0] -= @location.x
    coordinate[0] *= -1
    coordinate[1] -= @location.y

    @heading = Math.atan2(*coordinate) / degree
  end

  def goto(coordinate)
    start location
    draw CGPoint.new(*coordinate.flatten)
  end

  def forward(values)
    multiple(values).each { |steps| goto destination(+steps) }
  end

  def back(values)
    multiple(values).each { |steps| goto destination(-steps) }
  end

  def xy(coordinate)
    # coordinate [0, 0] is the lower left corner of the screen
    @penstatus = @penstatus.tap do
      penup

      coordinate[1] *= -1
      coordinate[1] += App.size.height

      goto coordinate
    end
  end

end

