class SnippetsController < UITableViewController

  extend IB

  outlet :snippets, UITableView

  def canBecomeFirstResponder
    true
  end

  def tableView(tableView, numberOfRowsInSection: row)
    Snippet.all._count + (@editing ? 1 : 0)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier('Snippet Cell')
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: 'Snippet Cell')

    if indexPath.row.eql? Snippet.all._count
      cell.showsReorderControl = false # this doesn't seem to do anything
      cell.textLabel.text = "Add New Snippet"
    else
      cell.textLabel.text = Snippet.locate(indexPath.row).title
    end

    cell
  end

  def tableView(tableView, editingStyleForRowAtIndexPath: indexPath)
    if not(@editing) || indexPath.nil?
      UITableViewCellEditingStyleNone
    elsif @editing
      if indexPath.row.eql? Snippet.all._count
        UITableViewCellEditingStyleInsert
      else
        UITableViewCellEditingStyleDelete
      end
    end
  end

  def tableView(tableView, moveRowAtIndexPath: fromIndexPath, toIndexPath: toIndexPath)
    moving, snippets = Snippet.all.sortBy(:snippet_id).partition do |snippet|
      snippet.snippet_id.eql? fromIndexPath.row
    end

    snippets.insert(toIndexPath.row, moving.first)
    snippets.each_with_index { |s, i| s.snippet_id = i }

    MotionData::Context.main.save Pointer.new(:object)
    MotionData::Context.current.saveChanges
    MotionData::Context.root.saveChanges
  end

  def tableView(tableView, canMoveRowAtIndexPath: indexPath)
    @editing unless indexPath.row.eql? Snippet.all._count
  end

  def tableView(tableView, canEditRowAtIndexPath: indexPath)
    @editing
  end

  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    if editingStyle.eql? UITableViewCellEditingStyleDelete

      MotionData::Context.main.deleteObject Snippet.locate(indexPath.row)

      MotionData::Context.main.save Pointer.new(:object)
      MotionData::Context.current.saveChanges
      MotionData::Context.root.saveChanges

      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationTop)

    elsif editingStyle.eql? UITableViewCellEditingStyleInsert
      @selected_snippet = Snippet.locate(indexPath.row)

      self.performSegueWithIdentifier("Edit Snippet", sender: self)

      setEditing(false, animated: true)
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    snippet = Snippet.locate(indexPath.row)

    if @editing
      @selected_snippet = snippet

      self.performSegueWithIdentifier("Edit Snippet", sender: self)
    else
      Popup.initWithMessage("Executing #{snippet.title}", title: "Loading Snippet")

      App.lectronimo.run snippet.content
    end
  end

  def prepareForSegue(segue, sender: sender)
    if segue.identifier.eql? 'Edit Snippet'
      controller = segue.destinationViewController

      controller.delegate = sender
      controller.snippet = @selected_snippet

      setEditing(false, animated: true)
    end
  end

  def save(controller)
    snippets.reloadData

    controller.navigationController.popViewControllerAnimated(true)

    @selected_snippet = nil
  end

  def setEditing(editing, animated: animated)
    super(editing, animated: animated).tap do
      @editing = editing

      MotionData::Context.main.save Pointer.new(:object)
      MotionData::Context.current.saveChanges
      MotionData::Context.root.saveChanges

      snippets.reloadData
    end
  end

  def viewWillAppear(animated)
    @editing = false

    super(animated).tap { snippets.reloadData }
  end

  def viewDidLoad
    super.tap do
      self.navigationItem.rightBarButtonItem = self.editButtonItem
    end
  end

end
