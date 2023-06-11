//
//  SuccessAddingVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit

class SuccessAddingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK:  IBActions
    
    @IBAction func goToHomeBtnAction(_ sender: UIButton) {
        
        basicPresentation(storyName: MAIN_STORYBOARD, segueId: "homeT")
    }
}
