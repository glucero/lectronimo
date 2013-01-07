class MainController < UIViewController

  extend IB

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

end

