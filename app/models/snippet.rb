class Snippet < MotionData::ManagedObject

  property :title,      String,    :required => true
  property :content,    String,    :required => true
  property :snippet_id, Integer16, :required => true

  include DefaultSnippets

  Defaults = [

    { :title   => "Polygon Command",
      :content => Polygon,
      :snippet_id => 0 },

    { :title   => "Pythagoras Tree Command",
      :content => PythagorasTree,
      :snippet_id => 1 }

  ]

  def self.create_defaults
    Defaults.each do |default|
      unless Snippet.locate(default[:snippet_id])
        Snippet.create(default)
      end
    end
  end

  def self.locate(id)
    Snippet.all.find { |s| s.snippet_id.eql? id }
  end

  def self.create(attributes)
    if snippet = Snippet.locate(attributes[:snippet_id])
      snippet.title = attributes[:title]
      snippet.content = attributes[:content]
    else
      attributes[:snippet_id] = Snippet.next_snippet_id

      Snippet.new attributes
    end

    Snippet.save
  end

  def self.save
    MotionData::Context.main.save Pointer.new(:object)
    MotionData::Context.current.saveChanges
    MotionData::Context.root.saveChanges
  end

  def self.delete(snippet)
    MotionData::Context.main.deleteObject snippet
    Snippet.save
  end

  def self.next_snippet_id
    snippets = Snippet.all.sortBy(:snippet_id).to_a

    snippets.empty? ? 0 : (snippets.last.snippet_id + 1)
  end

  def self.setup_core_data
    directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).last

    MotionData.setupCoreDataStackWithSQLiteStore File.join(directory, 'Snippets.sqlite')
  end

end
