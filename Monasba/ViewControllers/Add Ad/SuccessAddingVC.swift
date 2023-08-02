//
//  SuccessAddingVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit

class SuccessAddingVC: UIViewController {
    var isFromHome = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.isHidden = false

        
    }
    //MARK:  IBActions
    
    @IBAction func goToHomeBtnAction(_ sender: UIButton) {
        if isFromHome {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"goHome"), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
}
