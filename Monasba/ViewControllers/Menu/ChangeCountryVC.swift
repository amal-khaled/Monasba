//
//  ChangeCountryVC.swift
//  Monasba
//
//  Created by iOSayed on 03/06/2023.
//
import UIKit
import MOLH

class ChangeCountryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var counties = [Country]()
    var countryBtclosure : (( Country) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        counties = Constants.COUNTRIES

        if Constants.COUNTRIES.count == 0{
            getCounties()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
}
extension ChangeCountryVC{
    func getCounties(){
        CountryController.shared.getCountries(completion: {
            countries, check,msg in
            self.counties = countries
            Constants.COUNTRIES = countries
            print(self.counties.count)
            self.tableView.reloadData()
           
        })
    }
}
extension ChangeCountryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counties.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeCountyTableViewCell", for: indexPath) as! ChangeCountyTableViewCell
        if counties[indexPath.row].id == AppDelegate.currentUser.countryId {
            cell.checkImageView.isHidden = false
        }
        cell.setData(country: counties[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Constants.countryId = counties[indexPath.row].id ?? 0
        let homeVC = HomeViewController()
        homeVC.countryName = MOLHLanguage.currentAppleLanguage() == "en" ? (counties[indexPath.row].nameEn ?? "") : (counties[indexPath.row].nameAr ?? "")
        homeVC.countryId = counties[indexPath.row].id ?? 6
        homeVC.cityId = -1
        self.basicPresentation(storyName: MAIN_STORYBOARD, segueId: "homeT")

//        self.dismiss(animated: false, completion: { [self] in
//                        self.countryBtclosure!(counties[indexPath.row])
//
//            //counties[indexPath.row].id, MOLHLanguage.currentAppleLanguage() == "en" ? (counties[indexPath.row].nameEn ?? "") : (counties[indexPath.row].nameAr ?? ""), counties[indexPath.row].code
//        })
    }
}
