//
//  ReportViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 11/05/2023.
//

import UIKit

class ReportViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var reportList = ["prohibited on Monasba",
                     "Offensive or inappropriate","Identical or imitation product","Located in the wrong section","Looks like a scam", "The publisher is a fake or stolen account"]
    
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: false)
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
extension ReportViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReportTableViewCell
        cell.seetData(reason: reportList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProductController.shared.flageAd(completion: {
            check, msg in
            if check == 0 {
                StaticFunctions.createSuccessAlert(msg: msg)
                self.dismiss(animated: false)
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
            }
        }, id: id, reason: reportList[indexPath.row])
    }
}
