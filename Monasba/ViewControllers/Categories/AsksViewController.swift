//
//  AsksViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 27/05/2023.
//

import UIKit

class AsksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var asks = [Ask]()
    var page = 1
    var isTheLast = false
    var searchText = ""
    var cityId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
getData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAsk(_ sender: Any) {
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
extension AsksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AskTableViewCell
        cell.setData(ask: asks[indexPath.row])
        cell.showUserBtclosure = {
            let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: OTHER_USER_PROFILE_VCID) as! OtherUserProfileVC
            vc.user.id = self.asks[indexPath.row].userId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (asks.count-1) && !isTheLast{
            page+=1
            getData()

        }
    }
    

}

extension AsksViewController{
    func getData(){
        CategoryController.shared.getCityAsks(completion: {
            asks, check, msg in
            if check == 0{
                if self.page == 1 {
                    self.asks.removeAll()
                    self.asks = asks
                    
                }else{
                    self.asks.append(contentsOf: asks)
                }
                if asks.isEmpty{
                    self.page = self.page == 1 ? 1 : self.page - 1
                    self.isTheLast = true
                }
                self.tableView.reloadData()
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
                self.page = self.page == 1 ? 1 : self.page - 1
            }
        }, id: cityId, page: self.page)
    }
}
