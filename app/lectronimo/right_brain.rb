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
      @paths << { :color => UIColor.alloc.initWithRed(@pencolor[:red].to_f / 255,
                                                      green: @pencolor[:green].to_f / 255,
                                                      blue:  @pencolor[:blue].to_f / 255,
                                                      alpha: 1.0),

                  :line  => UIBezierPath.alloc.init.tap { |b| b.lineWidth = @pensize } }
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

