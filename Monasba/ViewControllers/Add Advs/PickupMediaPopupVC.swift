//
//  PickupMediaPopupVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit
import PhotosUI

protocol PickupMediaPopupVCDelegate: AnyObject {
    func PickupMediaPopupVC(_ controller: PickupMediaPopupVC, didSelectImages images: [UIImage])
}

class PickupMediaPopupVC: UIViewController {
 
    weak var delegate: PickupMediaPopupVCDelegate?
    var images = [UIImage]()
    
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
        openGallery()
        //dismiss(animated: true)
        
        
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
extension PickupMediaPopupVC : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       
        print(results)
        for (_,result) in results.enumerated() {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    print( "Fooo ",image)
                    let data = image.jpegData(compressionQuality: 0.01)
                    let newImage = UIImage(data: data!)
                    self.images.append(newImage! as UIImage)
//                    self.images.append(image)
                    print(self.images.count)
                }
                DispatchQueue.main.async {
                    self.delegate?.PickupMediaPopupVC(self, didSelectImages: self.images)
                }
            }
        }
        
        dismiss(animated: true,completion: nil)
    }
}
    


@available(iOS 14.0, *)
extension PickupMediaPopupVC {
    
    //MARK: Methods
    private func openGallery(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 6
        if #available(iOS 15.0, *) {
            config.selection = .ordered
        } else {
            // Fallback on earlier versions
        }
        let PHPickerVC = PHPickerViewController(configuration: config)
        PHPickerVC.delegate = self
        present(PHPickerVC, animated: true)
        
    }
    
    func generateThumbnail(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}

