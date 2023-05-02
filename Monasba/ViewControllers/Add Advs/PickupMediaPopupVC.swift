//
//  PickupMediaPopupVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit

class PickupMediaPopupVC: UIViewController {

    
    
    //MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    //MARK: IBActions
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        print("closeBtnAction")
        dismiss(animated: false)
        
    }
    
    @IBAction func openGalleryBtnAction(_ sender: UIButton) {
        print("openGalleryBtnAction")
        
    }
    
    @IBAction func openVideosBtnAction(_ sender: UIButton) {
        print("openVideosBtnAction")
        
    }
    
    @IBAction func openCameraBtnAction(_ sender: UIButton) {
        print("openCameraBtnAction")

    }
    
    @IBAction func recordVideoBtnAction(_ sender: UIButton) {
        print("recordVideoBtnAction")
        
    }
    
}
extension PickupMediaPopupVC {
    
}

