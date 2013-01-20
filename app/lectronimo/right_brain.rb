module RightBrain

  include Spectrum

  def reset
    home and clear
  end

  def each_path
    paths.each do |path|
      yield path[:color], path[:line]
    end
  end

  def paths
    @paths ||= []
  end

  def start(origin)
    if pendown?
      paths << { :color => UIColor.alloc.initWithRed(@pencolor[:red],
                                                     green: @pencolor[:green],
                                                     blue:  @pencolor[:blue],
                                                     alpha: 1.0),

                 :line  => UIBezierPath.alloc.init.tap { |b| b.lineWidth = @pensize } }
    end

    draw origin
  end

  def draw(point)
    if pendown?
      paths.last[:line].moveToPoint location
      paths.last[:line].addLineToPoint point
    end

    @location = point
  end

  def clear
    paths.clear
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
    @penstatus
  end

  def pensize(value)
    @pensize = single(value)
  end

  def pencolor(value)
    @pencolor = Colors[single value]
  end

  def randompencolor
    pencolor Colors.keys.sample
  end

end

