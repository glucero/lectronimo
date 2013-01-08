class CanvasController < UIViewController

  extend IB

  outlet :command, UITextField
  outlet :editor, UIButton
  outlet :back, UIButton

  outlet :icon, UIImageView

  def viewWillAppear(animated)
    super(animated).tap do
      self.navigationController.setNavigationBarHidden(true, animated: animated)
    end
  end

  def viewWillDisappear(animated)
    super(animated).tap do
      self.navigationController.setNavigationBarHidden(false, animated: animated)
    end
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end

  def startEditing
    editor.hidden = true
    back.hidden = true
    icon.hidden = true

    command.becomeFirstResponder
  end

  def textFieldDidBeginEditing(textField)
    animateTextField(textField, viewDirection: -200)
  end

  def textFieldDidEndEditing(textField)
    # why does it only take half as many pixels to drop back down?
    animateTextField(textField, viewDirection: 100)
  end

  def animateTextField(textField, viewDirection: viewDirection)
    view.frame = CGRectOffset(view.frame, 0, viewDirection)

    UIView.beginAnimations("animateTextField", context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(0.3)
    UIView.commitAnimations
  end

  def doneEditing(sender)
    editor.hidden = false
    back.hidden = false

    # run the commands
    App.lectronimo.run sender.text

    if App.lectronimo.visible?
      icon.hidden = false

      # move icon to new location
      icon.center = App.lectronimo.location

      # change icon's rotation to match new heading
      radians = App.lectronimo.direction * (Math::PI / 180)
      icon.transform = CGAffineTransformMakeRotation(-radians)
    else
      icon.hidden = true
    end

    view.setNeedsDisplay
  end

  def backButtonAction
    self.navigationController.popViewControllerAnimated(true)
  end

  def viewDidLoad
    @canvas = Canvas.alloc.init

    view.addSubview @canvas
  end

  def canBecomeFirstResponder
    true
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    # On the iPhone, don't rotate to upside-down portrait orientation
    unless UIDevice.currentDevice.userInterfaceIdiom.eql? UIUserInterfaceIdiomPad
      interfaceOrientation.eql? UIInterfaceOrientationPortraitUpsideDown
    end
  end
end
