class CommandsController < UIViewController

  include Vocabulary

  extend IB

  outlet :command_picker,   UIPickerView
  outlet :command_text,     UILabel
  outlet :aliases_text,     UILabel
  outlet :usage_text,       UILabel
  outlet :description_text, UILabel

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def viewDidLoad
    set_command Commands.first
  end

  def set_command(command)
    command_text.text = command[:name].upcase

    aliases_text.text = [].tap do |text|
      text << command[:name]

      if command[:alias]
        text << command[:alias].upcase
        text << command[:alias]
      end
    end.join(', ')

    usage_text.text = command[:examples].join("\n")
    description_text.text = command[:description]
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
