//
//  SearchViewController.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 05/03/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

enum CodeType {
    case CPT
    case ICD
}

class SearchViewController: UIViewController {

    
    @IBOutlet weak var btnCPT: UIButton!
    @IBOutlet weak var btnICD: UIButton!
    @IBOutlet weak var tblCodes: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var codesCPTArray:JSON?
    var selectedCPT :[Int] = []
    var codesICDArray:JSON?
    var selectedICD :[Int] = []
    
    var selectedCodeType = CodeType.CPT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        getDataFromT2CAPI()
        self.btnCPT.layer.borderWidth = 1.0
        self.btnCPT.layer.borderColor = UIColor.blue.cgColor
        self.btnICD.layer.borderWidth = 0.0
        self.btnICD.layer.borderColor = UIColor.clear.cgColor
        
//        self.codesCPTArray = [["amount":27824,
//                      "isSelected":false,
//                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"],
//                     ["amount":27825,
//                      "isSelected":false,
//                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"],
//                     ["amount":27826,
//                      "isSelected":false,
//                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"],
//                     ["amount":27827,
//                      "isSelected":false,
//                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"]]
//
//        self.codesICDArray = [["amount":93.56,
//                               "isSelected":false,
//                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"],
//                              ["amount":93.57,
//                               "isSelected":false,
//                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"],
//                              ["amount":93.58,
//                               "isSelected":false,
//                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"],
//                              ["amount":93.59,
//                               "isSelected":false,
//                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"]]
        
    }
    

    @IBAction func btnCodeClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.selectedCodeType = .CPT
            self.btnCPT.layer.borderWidth = 1.0
            self.btnCPT.layer.borderColor = UIColor.blue.cgColor
            self.btnICD.layer.borderWidth = 0.0
            self.btnICD.layer.borderColor = UIColor.clear.cgColor
        case 1:
            self.selectedCodeType = .ICD
            self.btnCPT.layer.borderWidth = 0.0
            self.btnCPT.layer.borderColor = UIColor.clear.cgColor
            self.btnICD.layer.borderWidth = 1.0
            self.btnICD.layer.borderColor = UIColor.blue.cgColor
        default:
            self.selectedCodeType = .CPT
            self.btnCPT.layer.borderWidth = 1.0
            self.btnCPT.layer.borderColor = UIColor.blue.cgColor
            self.btnICD.layer.borderWidth = 0.0
            self.btnICD.layer.borderColor = UIColor.clear.cgColor
        }
        self.tblCodes.reloadData()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueCPTDetails" {
            let destiVC = segue.destination as? CPTDetailViewController
            destiVC?.codesCPTArray = self.codesCPTArray
            destiVC?.codesICDArray = self.codesICDArray
            destiVC?.selectedCodeType =  selectedCodeType
            let object = sender as? JSON
            switch selectedCodeType {
            case .CPT:
                destiVC?.selectedCode = object!["CPTcode"].stringValue
                destiVC?.selectedCodeDesc = object!["LongDesc"].stringValue
                destiVC?.selectObject = object?.dictionaryObject
            case .ICD:
                destiVC?.selectedCode = object!["ProcCode"].stringValue
                destiVC?.selectedCodeDesc = object!["ProcDesc"].stringValue
                destiVC?.selectObject = object?.dictionaryObject
            }
        }
    }
    
    @objc func btnCheckBoxClicked(sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            switch selectedCodeType {
                case .CPT:
                    let obj = self.codesCPTArray![sender.tag]
                    self.selectedCPT.append(obj["id"].intValue)
                case .ICD:
                    let obj = self.codesICDArray![sender.tag]
                    self.selectedICD.append(obj["id"].intValue)
            }
        } else {
            switch selectedCodeType {
                case .CPT:
                    let obj = self.codesCPTArray![sender.tag]
                    if let index = self.selectedCPT.index(of: obj["id"].intValue) {
                        self.selectedCPT.remove(at: index)
                    }
                case .ICD:
                    let obj = self.codesICDArray![sender.tag]
                    if let index = self.selectedICD.index(of: obj["id"].intValue) {
                        self.selectedICD.remove(at: index)
                    }
            }
        }
    }
    
    @IBAction func btnAddToCartClicked(_ sender: Any) {
        //Get All Selected Data
        let cptArray = self.codesCPTArray?.arrayObject as! [Dictionary<String, Any>]
        let filterCPT = cptArray.filter({ selectedCPT.contains($0["id"] as! Int)})
        let icdArray = self.codesICDArray?.arrayObject as! [Dictionary<String, Any>]
        let filtericd = icdArray.filter({ selectedICD.contains($0["id"] as! Int)})
        
        UserDefaults.standard.set(filterCPT, forKey: "CPTCart")
        UserDefaults.standard.set(filtericd, forKey: "ICDCart")
        UserDefaults.standard.synchronize()
//        print(filterCPT)
//        print(filtericd)
        self.tabBarController?.selectedIndex = 2
    }
    func getDataFromT2CAPI() {
        
        if let path = Bundle.main.path(forResource: "apiSinglePhrase", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                self.codesCPTArray = jsonObj["CPThcpcs"]
                self.codesICDArray = jsonObj["ICD10Procedure"]
                self.tblCodes.reloadData()
                print("jsonData:\(jsonObj)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
}

extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectedCodeType {
        case .CPT:
            return 85.0
        case .ICD:
            return 70.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedCodeType {
        case .CPT:
            return self.codesCPTArray?.count ?? 0
        case .ICD:
            return self.codesICDArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch selectedCodeType {
        case .CPT:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CPTCell", for: indexPath) as? CPTTableViewCell
            
            let object = self.codesCPTArray![indexPath.row]
            let amount = object["FacTotal"].stringValue
            cell?.lblAmount.text = "$\(amount)"
            cell?.lblDesc.text = object["LongDesc"].stringValue
            
            if selectedCPT.contains(object["id"].intValue) {
                cell?.btnCheckBox.isSelected = true
            } else {
                cell?.btnCheckBox.isSelected = false
            }
//            cell?.btnCheckBox.isSelected = self.codesCPTArray?[indexPath.row]["isSelected"] as? Bool ?? false
//            cell?.btnCheckBox.addTarget(self, action: Selecto, for: .touchUpInside)
            cell?.btnCheckBox.addTarget(self, action: #selector(SearchViewController.btnCheckBoxClicked(sender:)), for: .touchUpInside)
            cell?.btnCheckBox.tag = indexPath.row
            cell?.selectionStyle = .none
//            configureCell(cell: cell, forRowAt: indexPath)
            return cell!
        case .ICD:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ICDCell", for: indexPath) as? ICDTableViewCell
            
            let object = self.codesICDArray![indexPath.row]
            let amount = object["ProcCode"].stringValue
            cell?.lblAmount.text = "\(amount)"
            cell?.lblDesc.text = object["ProcDesc"].stringValue
            
            if selectedICD.contains(object["id"].intValue) {
                cell?.btnCheckBox.isSelected = true
            } else {
                cell?.btnCheckBox.isSelected = false
            }
//            cell?.btnCheckBox.isSelected = self.codesICDArray?[indexPath.row]["isSelected"] as? Bool ?? false
            cell?.btnCheckBox.addTarget(self, action: #selector(SearchViewController.btnCheckBoxClicked(sender:)), for: .touchUpInside)
            cell?.btnCheckBox.tag = indexPath.row
            cell?.selectionStyle = .none
//            configureCell(cell: cell, forRowAt: indexPath)
            return cell!
        }
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object : JSON?
        switch selectedCodeType {
        case .CPT:
            object = self.codesCPTArray?[indexPath.row]
        case .ICD:
            object = self.codesICDArray?[indexPath.row]
        }
            
        self.performSegue(withIdentifier: "segueCPTDetails", sender: object)
    }
    
    
    
}

extension SearchViewController : UISearchBarDelegate {
    
    // This method updates filteredVenueList based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        // When there is no text, filteredVenueList is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        if (searchBar.text != nil) && searchBar.text!.count >= 3 {
            searchTermOnT2C(termText: searchBar.text!)
        }
        
    }
    
    func searchTermOnT2C(termText: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let params : Parameters = [ "NLP" : termText ]
        
        CodeNetwork().getSearchCodesList(searchText: termText,params: params) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.result.error == nil){
                print("Response ",response.result)
                if let data = response.data {
                    
                    do {
                        let jsonObj = try JSON(data: data)
                        self.codesCPTArray = jsonObj["CPThcpcs"]
                        print("codesCPTArray ",self.codesCPTArray)
                        self.codesICDArray = jsonObj["ICD10Procedure"]
                        print("codesICDArray ",self.codesICDArray)
                        self.tblCodes.reloadData()
                    } catch {
                        print(error.localizedDescription)
                        // self.displayError(message: "Unable to fetch brand denominations")
                    }
                }
            }else{
                print(response.result.error)
            }
        }
    }
    
}
