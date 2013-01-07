module Body

  def location
    @location ||= App.center
  end

  def visibile
    @visibile
  end

  def show
    @visibile = true
  end

  def hide
    @visibile = false
  end

  def home
    heading 0.0
    xy App.center.to_a
  end

  def direction
    @heading
  end

  def heading(value)
    degrees = single(value)

    @heading = degrees
  end

  def rotate(degrees)
    @heading += degrees
    @heading += 360.0 while @heading < 0.0
    @heading -= 360.0 while @heading > 359.0
  end

  # orientation:
  # lectronimo  vs.  iphone
  #     2              -2
  #     1              -1
  #-2-1 0 1 2      -2-1 0 1 2
  #    -1               1
  #    -2               2
  def right(values) # turn left
    multiple(values).each { |degree| rotate(-degree) }
  end

  def left(values) # turn right
    multiple(values).each { |degree| rotate(+degree) }
  end

  def destination(steps)
    coordinates  = { :sin => location.x, :cos => location.y }
    coordinates.map do |function, coordinate|
      radians    = (@heading - 180) * degree # flip heading 180°
      offset     = steps * send(function, radians)
      coordinate + offset
    end
  end

  def goto(coordinate)
    start_path location
    path_to CGPoint.new(*coordinate.flatten)
  end

  def forward(values)
    multiple(values).each { |steps| goto destination(+steps) }
  end

  def back(steps)
    multiple(values).each { |steps| goto destination(-steps) }
  end

  def xy(coordinate)
    @penstatus = @penstatus.tap do
      penup
      goto coordinate
    end
  end

  def face(coordinate)
    x = coordinate.first - @location.x
    y = coordinate.last - @location.y

    @heading = Math.atan2(x, y) / degree
  end

end

