//
//  MPPageViewController.swift
//  MPPageViewController
//
//  Created by Manish on 10/31/18.
//  Copyright © 2018 MANHYA. All rights reserved.
//

import UIKit

class MPPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var orderViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "vc1"),
                self.newVc(viewController: "vc2")]
        
    }()
    
    var pagecontroll = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = orderViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.delegate = self
        configurepagecontroll()
        // Do any additional setup after loading the view.
    }
    
    func configurepagecontroll() {
        pagecontroll = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 150, width: UIScreen.main.bounds.width, height: 50))
        pagecontroll.numberOfPages = orderViewControllers.count
        pagecontroll.currentPage = 0
        pagecontroll.tintColor = UIColor .black
        pagecontroll.pageIndicatorTintColor = UIColor.white
        pagecontroll.currentPageIndicatorTintColor = UIColor.init(red: 1/265, green: 165/265, blue: 210/265, alpha: 1)
        self.view.addSubview(pagecontroll)
    }

    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewcontroller: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            //return orderViewControllers.last
            return nil
        }
        
        guard orderViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewcontroller: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderViewControllers.count != nextIndex else {
            //return orderViewControllers.first
            return nil
        }
        
        guard orderViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers previousViewController: [UIViewController], transitionCompleted complted: Bool) {
        let pageContentViewController = pageViewController.viewControllers?[0]
        self.pagecontroll.currentPage = orderViewControllers.index(of : pageContentViewController!)!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
