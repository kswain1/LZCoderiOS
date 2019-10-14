//
//  CartViewController.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 14/10/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tblCartList: UITableView!
    var cptCartData : [[String:Any]] = []
    var icdCartData : [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        cptCartData = UserDefaults.standard.array(forKey: "CPTCart") as? [[String : Any]] ?? []
        icdCartData = UserDefaults.standard.array(forKey: "ICDCart") as? [[String : Any]] ?? []
        print(cptCartData)
        print(icdCartData)
        
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

extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cptCartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell
        let object = self.cptCartData[indexPath.row]
        cell?.lblCode.text = object["CPTcode"] as? String
        cell?.lblName.text = "\(object["id"] as! Int)"
            cell?.selectionStyle = .none
            //            configureCell(cell: cell, forRowAt: indexPath)
            return cell!
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDelegate
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let object : JSON?
//        switch selectedCodeType {
//        case .CPT:
//            object = self.codesCPTArray?[indexPath.row]
//        case .ICD:
//            object = self.codesICDArray?[indexPath.row]
//        }
//
//        self.performSegue(withIdentifier: "segueCPTDetails", sender: object)
//    }
    
    
    
}
