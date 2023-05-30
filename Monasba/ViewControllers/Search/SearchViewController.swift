//
//  SearchViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 18/05/2023.
//

import UIKit
protocol ContentDelegate {
    func updateContent(searchText: String)
 }
class SearchViewController: UIViewController {
  
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var personLbl: UILabel!
    @IBOutlet weak var adsView: UIView!
    @IBOutlet weak var adsLbl: UILabel!
    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var peresonView: UIView!
    @IBOutlet weak var questionsView: UIView!
    var searchText = ""
    var delegate: ContentDelegate?
    var delegate1: ContentDelegate?
    var delegate2: ContentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func adsBtnAction(_ sender: Any) {
        adsLbl.textColor = UIColor(named: "#0EBFB1")
        adsView.backgroundColor = UIColor(named: "#0EBFB1")
        
        personLbl.textColor = UIColor(named: "#929292")
        personView.backgroundColor = UIColor(named: "#929292")

        questionLbl.textColor = UIColor(named: "#929292")
        questionView.backgroundColor = UIColor(named: "#929292")
        
        adView.isHidden = false
        peresonView.isHidden = true
        questionsView.isHidden = true

    }
    @IBAction func personsBtnAction(_ sender: Any) {
        adsLbl.textColor = UIColor(named: "#929292")
        adsView.backgroundColor = UIColor(named: "#929292")

        personLbl.textColor = UIColor(named: "#0EBFB1")
        personView.backgroundColor = UIColor(named: "#0EBFB1")

        questionLbl.textColor = UIColor(named: "#929292")
        questionView.backgroundColor = UIColor(named: "#929292")
        
        adView.isHidden = true
        peresonView.isHidden = false
        questionsView.isHidden = true
    }
    @IBAction func questionsBtnAction(_ sender: Any) {
        adsLbl.textColor = UIColor(named: "#929292")
        adsView.backgroundColor = UIColor(named: "#929292")

        personLbl.textColor = UIColor(named: "#929292")
        personView.backgroundColor = UIColor(named: "#929292")

        questionLbl.textColor = UIColor(named: "#0EBFB1")
        questionView.backgroundColor = UIColor(named: "#0EBFB1")
        
        adView.isHidden = true
        peresonView.isHidden = true
        questionsView.isHidden = false
    }
    
    /*
    // MARK: - Navigation

 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if segue.identifier == "ads" {
        if let firstChildCV = segue.destination as? SearchAdsViewController {
            self.delegate = firstChildCV
             //Access your child VC elements
           }
        }
        if segue.identifier == "persons"{
        if let secondChildCV = segue.destination as? SearchPersonViewController {
            self.delegate1 = secondChildCV

             //Access your child VC elements
           }
          }
        if segue.identifier == "questions"{
        if let secondChildCV = segue.destination as? SearchAskViewController {
            self.delegate2 = secondChildCV

             //Access your child VC elements
           }
          }
        
    }
}
extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(
               withTarget: self,
               selector: #selector(self.getHintsFromTextField),
               object: searchBar)
           self.perform(
               #selector(self.getHintsFromTextField),
               with: searchBar,
               afterDelay: 0.5)
        
        self.searchText = searchText
        
    }
    @objc func getHintsFromTextField(searchBar: UISearchBar) {
        self.searchText = searchBar.text!

        self.delegate?.updateContent(searchText: searchText)
        self.delegate1?.updateContent(searchText: searchText)
        self.delegate2?.updateContent(searchText: searchText)

    }
}
