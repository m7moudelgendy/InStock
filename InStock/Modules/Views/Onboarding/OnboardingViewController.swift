

import UIKit
import Reachability

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    let reachability = try! Reachability()

    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let userArr = CoreDataManager.FetchFromCoreData()
     //   if userArr.count == 0
     //   {
            
            slides = [
                OnboardingSlide(title: "InStock App", description: "All That you need , All That you want just Hello at InStock .", image: #imageLiteral(resourceName: "WhatsApp Image 2023-03-13 at 1.20.41 AM")),
                OnboardingSlide(title: "To Discover more Feature", description: "just Join InStock .", image: #imageLiteral(resourceName: "undraw_develop_app_re_bi4i")),
                OnboardingSlide(title: "Add Payment Way", description: "You can use Apple Pay Or In Cash.", image: #imageLiteral(resourceName: "WhatsApp Image 2023-03-13 at 1.20.42 AM")),
                OnboardingSlide(title: "Let's Discover InStock", description: "", image: #imageLiteral(resourceName: "undraw_Home_screen_re_640d"))
            ]
            
            pageControl.numberOfPages = slides.count
      //  }
      //  else
     //   {
        //    let controller = storyboard?.instantiateViewController(identifier: "TabBarController") as! UITabBarController
        //     controller.modalPresentationStyle = .fullScreen
        //     controller.modalTransitionStyle = .flipHorizontal
        //      present(controller, animated: true, completion: nil)
       // }
        
    }
    override func viewWillAppear(_ animated: Bool) {
           NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
           do {
               try reachability.startNotifier()
           } catch
            {
               print("Unable to start notifier")
           }
       }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            switch reachability.connection {
                // INternet
            case .wifi , .cellular:
                let controller = storyboard?.instantiateViewController(identifier: "TabBarController") as! UITabBarController
                 controller.modalPresentationStyle = .fullScreen
                 controller.modalTransitionStyle = .flipHorizontal
                  present(controller, animated: true, completion: nil)
     
               //UNAnvaliabe Internet
            case .unavailable , .none:
                let alert = UIAlertController(title:"No Internet !", message: "Make Sure Of Internet Connection", preferredStyle: .alert)
                
               alert.addAction(UIAlertAction(title: "Ok ", style: .default, handler: nil))
                var imgTitle = UIImageView(frame: CGRect(x: 50, y: 14, width: 32, height: 32))
                imgTitle.image = UIImage(named: "nointernet")
                alert.view.addSubview(imgTitle)
                self.present(alert, animated: true, completion: nil)
                print(" unavailable No Connection")
           }
        }
          else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    // check reachabilityChanged
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
 
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
