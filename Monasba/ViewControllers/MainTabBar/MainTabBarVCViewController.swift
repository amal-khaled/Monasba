//
//  MainTabBarVCViewController.swift
//  Monasba
//
//  Created by iOSayed on 03/06/2023.
//

import UIKit

class MainTabBarVCViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
    }
  
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
//           
//           if index == 3 {
//               let vc = UIStoryboard(name: SEARCH_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "search_base") as! SearchBaseViewController
//
//                          // Check if the selected view controller is already embedded in a UINavigationController.
//                          if let navigationController = tabBarController.selectedViewController as? UINavigationController {
//                              navigationController.pushViewController(vc, animated: true)
//                          } else {
//                              // If not, create a new navigation controller and set it as the selected tab's view controller.
//                              let newNavigationController = UINavigationController(rootViewController: vc)
//                              tabBarController.selectedViewController = newNavigationController
//        
//                          }
//               
//               return false
//           }
//       }
//
//        return true
//    }
//    
//    

}
