//
//  HomeViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var countryId = 6
    var categoryId = -1
    var subcategoryId = -1
    var page = 1
    var isTheLast = false
    var sell:Int?
    var sorting = "newest"
    var cityId = -1

    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterAction(_ sender: Any) {
    }
    
    @IBAction func sortActioon(_ sender: Any) {
    }
    @IBAction func typeActiion(_ sender: Any) {
    }
    @IBAction func countryAction(_ sender: Any) {
    }
    @IBAction func gridAction(_ sender: Any) {
    }
    @IBAction func ListAction(_ sender: Any) {
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
