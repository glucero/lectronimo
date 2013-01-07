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

      MotionData::Context.main.save Pointer.new(:object)
      MotionData::Context.current.saveChanges
      MotionData::Context.root.saveChanges
    end

    snippet = nil # release the snippet incase the view is reused

    self.delegate.save(self)
  end

end
