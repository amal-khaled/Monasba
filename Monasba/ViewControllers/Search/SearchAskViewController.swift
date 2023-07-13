//
//  SearchAskViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 24/05/2023.
//

import UIKit

class SearchAskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var asks = [Ask]()
    var page = 1
    var isTheLast = false
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
//        getData()
        // Do any additional setup after loading the view.
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
extension SearchAskViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AskTableViewCell
        cell.setData(ask: asks[indexPath.row])
        cell.showUserBtclosure = {
            let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: OTHER_USER_PROFILE_VCID) as! OtherUserProfileVC
            vc.navigationController?.navigationBar.isHidden = true
            vc.OtherUserId = self.asks[indexPath.row].userId ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.deleteBtclosure = {
            CategoryController.shared.deleteAsk(completion: {
                check, msg in
                if check == 0{
                    StaticFunctions.createSuccessAlert(msg: msg)
                    self.asks.removeAll()

                    self.page = 1
                    self.isTheLast = false
                    self.getData()
                }else{
                    StaticFunctions.createErrorAlert(msg: msg)

                }
            }, id: self.asks[indexPath.row].id ?? 0)
        }
        cell.zoomBtclosure = {
            if let quesPicture = self.asks[indexPath.row].pic{
                
                let zoomCtrl = VKImageZoom()
                zoomCtrl.image_url = URL.init(string: "\(Constants.IMAGE_URL)\(quesPicture)")
                print("zoomCtrl.image_url ====> ",zoomCtrl.image_url , "\(Constants.IMAGE_URL)\(quesPicture)")
                self.present(zoomCtrl, animated: true, completion: nil)
                
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: CATEGORRY_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: COMMENT_REPLY_VCID) as! AskRepliesViewController
        vc.data.question = self.asks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (asks.count-1) && !isTheLast{
            page+=1
            getData()

        }
    }
    

}

extension SearchAskViewController{
    func getData(){
        SearchController.shared.searchِAsk(completion: {
            asks, check, msg in
            if check == 0{
                if self.page == 1 {

                    self.asks.removeAll()
                    self.tableView.reloadData()

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
        }, id: AppDelegate.currentUser.id ?? 0, searchText: searchText, page: self.page)
    }
}
extension SearchAskViewController: ContentDelegate{
    func updateContent(searchText: String) {
        self.searchText = searchText
        self.page = 1
            self.isTheLast = false
        getData()
    }
    
    
}
