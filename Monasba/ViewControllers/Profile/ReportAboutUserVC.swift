//
//  ReportAboutUserVC.swift
//  Monasba
//
//  Created by iOSayed on 02/05/2023.
//

import UIKit

class ReportAboutUserVC: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //TODO :- translate and ckeck App language
    let reasonsList = ["سبام او محتوى غير مرغوب فيه","يحتوي على معلومات وهمية","يحوي كلمات مسيئة ومحتوى ينطوي على التنمر والعنف","يحض على الكراهية","سبب آخر ...."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }

}
extension ReportAboutUserVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReportTableViewCell", for: indexPath) as? ReportTableViewCell else{return UITableViewCell()}
        cell.reasonLabel.text = reasonsList[indexPath.row]
        return cell
    }
    
    
}
