class CommandsController < UIViewController

  include Vocabulary

  extend IB

  outlet :commands,    UIPickerView
  outlet :name,        UILabel
  outlet :aliases,     UILabel
  outlet :usage,       UILabel
  outlet :description, UILabel

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def viewDidLoad
    set_command Commands.first
  end

  def set_command(command)
    name.text = command[:name].upcase

    aliases.text = [].tap do |text|
      text << command[:name]

      if command[:alias]
        text << command[:alias].upcase
        text << command[:alias]
      end
    end.join(', ')

    usage.text = command[:examples].join("\n")
    description.text = command[:description]
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    Commands.count
  end

  def pickerView(pickerView, titleForRow: row, forComponent: component)
    Commands[row][:name].upcase
  end

  def pickerView(pickerView, didSelectRow: row, inComponent: component)
    set_command Commands[row]
  end

end
