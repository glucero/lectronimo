module RightBrain

  include Spectrum

  def each_path
    @paths.each do |path|
      yield path[:color], path[:line]
    end
  end

  def reset
    home and clear
  end

  def start_path(origin)
    if pendown?
      path = UIBezierPath.alloc.init
      path.lineWidth = @pensize

      @paths << { :color => current_pen_color, :line => path }
    end

    path_to origin
  end

  def path_to(point)
    if pendown?
      @paths.last[:line].moveToPoint location
      @paths.last[:line].addLineToPoint point
    end

    @location = point
  end

  def clear
    @paths.clear
  end

  def current_pen_color
    UIColor.alloc.initWithRed(@pencolor[:red].to_f / 255,
                              green:@pencolor[:green].to_f / 255,
                              blue:@pencolor[:blue].to_f / 255,
                              alpha:1.0)
  end

  def pendown
    @penstatus = true
  end

  def penup
    @penstatus = false
  end

  def pendown?
    @penstatus
  end

  def penup?
    not pendown?
  end

  def pensize(value)
    size = single(value)

    @pensize = size
  end

  def pencolor(value)
    color = single(value)

    @pencolor = Colors[color]
  end

  def randompencolor
    color = Colors.keys[rand(Colors.keys.size)]

    pencolor color
  end

end

