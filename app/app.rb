class App

  attr_reader :screen, :storyboard, :lectronimo

  def self.delegate
    UIApplication.sharedApplication.delegate
  end

  def self.screen
    App.delegate.screen
  end

  def self.storyboard
    App.delegate.storyboard
  end

  def self.lectronimo
    App.delegate.lectronimo
  end

  def self.size
    UIScreen.mainScreen.bounds.size
  end

  def self.center
    CGPoint.new(App.size.width / 2, App.size.height / 2)
  end

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    application.setStatusBarHidden(true, withAnimation: UIStatusBarAnimationFade)

    Snippet.setup_core_data
    Snippet.create_defaults

    @screen = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @lectronimo = Lectronimo.new

    # if App.size.eql? CGSize.new(320, 480)
      # @storyboard = UIStoryboard.storyboardWithName('iPhone4StoryBoard', bundle: nil)
    # else
      # @storyboard = UIStoryboard.storyboardWithName('iPhone5StoryBoard', bundle: nil)
    # end

    @storyboard = UIStoryboard.storyboardWithName("Storyboard", bundle: nil)

    @screen.rootViewController = @storyboard.instantiateInitialViewController
    @screen.makeKeyAndVisible
  end

end
