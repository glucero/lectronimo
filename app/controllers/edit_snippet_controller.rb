class EditSnippetController < UITableViewController

  extend IB

  outlet :title,   UITextField
  outlet :content, UITextView

  attr_accessor :delegate,
                :snippet

  def viewDidLoad
    if snippet
      title.text   = snippet.title
      content.text = snippet.content
    end
  end

  def viewDidUnload
    snippet = nil
  end

  def save(sender)
    MotionData::Context.withCurrent(MotionData::Context.context) do

      attributes = { :title => title.text, :content => content.text }
      attributes[:snippet_id] = snippet.snippet_id if snippet

      Snippet.create attributes
      Snippet.save
    end

    self.delegate.save(self)
  end

  def canBecomeFirstResponder
    true
  end

end
