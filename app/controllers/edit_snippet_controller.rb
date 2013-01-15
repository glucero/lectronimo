class EditSnippetController < UITableViewController

  extend IB

  outlet :title, UITextField
  outlet :content, UITextView

  attr_accessor :delegate, :snippet

  def viewDidLoad
    unless snippet.nil?
      title.text = snippet.title
      content.text = snippet.content
    end
  end

  def viewDidUnload
    snippet = nil
  end

  def save(sender)
    MotionData::Context.withCurrent(MotionData::Context.context) do

      attributes = { :title => title.text, :content => content.text }

      unless snippet.nil?
        attributes[:snippet_id] = snippet.snippet_id
      end

      Snippet.create attributes
      Snippet.save
    end

    self.delegate.save(self)
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
