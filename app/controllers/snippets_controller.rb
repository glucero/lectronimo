class SnippetsController < UITableViewController

  Cell = 'Snippet Cell'

  extend IB

  outlet :snippets, UITableView

  def canBecomeFirstResponder
    true
  end

  def tableView(tableView, numberOfRowsInSection: row)
    Snippet.all._count + (@editing ? 1 : 0)
  end

  def tableCell(tableView)
    tableView.dequeueReusableCellWithIdentifier(Cell) or
    UITableViewCell.alloc.initWithStyle(UITableViewCelStyleDefault, resuseIdentifier: Cell)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    tableCell(tableView).tap do |cell|
      if indexPath.row.eql? Snippet.all._count
        cell.showsReorderControl = false
        cell.textLabel.text = 'Add New Snippet'
      else
        cell.textLabel.text = Snippet.locate(indexPath.row).title
      end
    end
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

    Snippet.save
  end

  def tableView(tableView, canMoveRowAtIndexPath: indexPath)
    @editing unless indexPath.row.eql? Snippet.all._count
  end

  def tableView(tableView, canEditRowAtIndexPath: indexPath)
    @editing
  end

  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    if editingStyle.eql? UITableViewCellEditingStyleDelete
      Snippet.delete Snippet.locate(indexPath.row)

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
      Popup.initWithMessage(snippet.title, title: "Executing Snippet")

      Dispatch::Queue.main.async do
        App.lectronimo.run snippet.content

        Dispatch::Queue.main.async { canvasController.updateCanvas }
      end
    end
  end

  def canvasController
    self.navigationController.viewControllers.find do |controller|
      controller.is_a? CanvasController
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

    @selected_snippet = nil # release snippet in case the view is reused
  end

  def setEditing(editing, animated: animated)
    super(editing, animated: animated).tap do
      @editing = editing

      Snippet.save

      snippets.reloadData
    end
  end

  def viewWillAppear(animated)
    super.tap do
      @editing = false

      snippets.reloadData
    end
  end

  def viewDidLoad
    super.tap do
      self.navigationItem.rightBarButtonItem = self.editButtonItem
    end
  end

end
