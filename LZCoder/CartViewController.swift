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
    @IBOutlet weak var tblProductList: UITableView!
    @IBOutlet weak var btnFacility: UIButton!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var btnNonFacility: UIButton!
    var cptCartData : [[String:Any]] = []
    var icdCartData : [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cptCartData = UserDefaults.standard.array(forKey: "CPTCart") as? [[String : Any]] ?? []
        icdCartData = UserDefaults.standard.array(forKey: "ICDCart") as? [[String : Any]] ?? []
        print(cptCartData)
        print(icdCartData)
        self.btnFacility.isSelected = true
        let priceList = self.cptCartData.map { $0["FacTotal"] as! String }
        var total = 0.0
        for price in priceList {
            let priceDouble = Double(price)
            total = total + priceDouble!
        }
        self.lblPriceTotal.text = String(format:"$%.2f", total)
        self.tblCartList.reloadData()
        self.tblProductList.reloadData()
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func btnFacilityClick(_ sender: Any) {
        if self.btnFacility.isSelected {
            self.btnFacility.isSelected = false
            self.btnNonFacility.isSelected = true
            let priceList = self.cptCartData.map { $0["NonFacTotal"] as! String }
            var total = 0.0
            for price in priceList {
                let priceDouble = Double(price)
                total = total + priceDouble!
            }
            self.lblPriceTotal.text = String(format:"$%.2f", total)
        } else {
            self.btnFacility.isSelected = true
            self.btnNonFacility.isSelected = false
            let priceList = self.cptCartData.map { $0["FacTotal"] as! String }
            var total = 0.0
            for price in priceList {
                let priceDouble = Double(price)
                total = total + priceDouble!
            }
            self.lblPriceTotal.text = String(format:"$%.2f", total)
        }
        self.tblProductList.reloadData()
    }
    @IBAction func btnNonFacilityClick(_ sender: Any) {
        if self.btnNonFacility.isSelected {
            self.btnFacility.isSelected = true
            self.btnNonFacility.isSelected = false
            let priceList = self.cptCartData.map { $0["FacTotal"] as! String }
            var total = 0.0
            for price in priceList {
                let priceDouble = Double(price)
                total = total + priceDouble!
            }
            self.lblPriceTotal.text = String(format:"$%.2f", total)
        } else {
            self.btnFacility.isSelected = false
            self.btnNonFacility.isSelected = true
            let priceList = self.cptCartData.map { $0["NonFacTotal"] as! String }
            var total = 0.0
            for price in priceList {
                let priceDouble = Double(price)
                total = total + priceDouble!
            }
            self.lblPriceTotal.text = String(format:"$%.2f", total)
        }
        self.tblProductList.reloadData()
    }

}

extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblCartList {
            return self.cptCartData.count
        } else {
            return self.cptCartData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tblCartList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartTableViewCell
            let object = self.cptCartData[indexPath.row]
            cell?.lblCode.text = object["CPTcode"] as? String
            cell?.lblName.text = "\(object["id"] as! Int)"
            cell?.selectionStyle = .none
            //            configureCell(cell: cell, forRowAt: indexPath)
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProjectListTableViewCell
            let object = self.cptCartData[indexPath.row]
            cell?.lblCode.text = object["CPTcode"] as? String
            cell?.lblType.text = "\(object["id"] as! Int)"
            if self.btnFacility.isSelected {
                cell?.lblPrice.text = "$\(object["FacTotal"] as! String)"
            } else{
                cell?.lblPrice.text = "$\(object["NonFacTotal"] as! String)"
            }
            
            cell?.selectionStyle = .none
            return cell!
        }
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.cptCartData.remove(at:indexPath.row)
            UserDefaults.standard.set(self.cptCartData, forKey: "CPTCart")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            if self.btnNonFacility.isSelected {
                let priceList = self.cptCartData.map { $0["FacTotal"] as! String }
                var total = 0.0
                for price in priceList {
                    let priceDouble = Double(price)
                    total = total + priceDouble!
                }
                self.lblPriceTotal.text = String(format:"$%.2f", total)
            } else {
                let priceList = self.cptCartData.map { $0["NonFacTotal"] as! String }
                var total = 0.0
                for price in priceList {
                    let priceDouble = Double(price)
                    total = total + priceDouble!
                }
                self.lblPriceTotal.text = String(format:"$%.2f", total)
            }
            self.tblProductList.reloadData()
        }
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
