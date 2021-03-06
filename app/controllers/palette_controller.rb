class PaletteController < UIViewController

  include Spectrum

  extend IB

  outlet :color_picker, UIPickerView
  outlet :swatch,       UIView
  outlet :red,          UILabel
  outlet :green,        UILabel
  outlet :blue,         UILabel

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def viewDidLoad
    set_color Colors[:'alice-blue']
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    Colors.keys.count
  end

  def pickerView(pickerView, titleForRow: row, forComponent: component)
    Colors.keys[row].upcase
  end

  def set_color(color)
    swatch.color = color

    [red, green, blue].zip(color.keys) do |level, hue|
      level.text = '%.4f' % color[hue]
    end
  end

  def pickerView(pickerView, didSelectRow: row, inComponent: component)
    color_name = Colors.keys[row]
    set_color Colors[color_name]

    swatch.setNeedsDisplay
  end

end
