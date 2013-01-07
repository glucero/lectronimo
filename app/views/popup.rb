class Popup

  def self.initWithMessage(message, title: title)
    Popup.new(message.to_s, title.to_s).show
  end

  def initialize(message, title)
    @message = message
    @title = title
  end

  def view
    UIAlertView.alloc.init.tap do |popup|
      popup.title   = @title
      popup.message = @message

      popup.addButtonWithTitle 'OK'
      popup.cancelButtonIndex = 0
    end
  end

  def show
    view.show
  end

end
