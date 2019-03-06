//
//  SearchViewController.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 05/03/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit

enum CodeType {
    case CPT
    case ICD
}

class SearchViewController: UIViewController {

    
    @IBOutlet weak var btnCPT: UIButton!
    @IBOutlet weak var btnICD: UIButton!
    @IBOutlet weak var tblCodes: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var codesCPTArray:[[String:Any]]?
    var codesICDArray:[[String:Any]]?
    
    var selectedCodeType = CodeType.CPT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.btnCPT.layer.borderWidth = 1.0
        self.btnCPT.layer.borderColor = UIColor.blue.cgColor
        self.btnICD.layer.borderWidth = 0.0
        self.btnICD.layer.borderColor = UIColor.clear.cgColor
        
        self.codesCPTArray = [["amount":27824,
                      "isSelected":false,
                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"],
                     ["amount":27825,
                      "isSelected":false,
                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"],
                     ["amount":27826,
                      "isSelected":false,
                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"],
                     ["amount":27827,
                      "isSelected":false,
                      "detialText":"Closed treatment of fracture of weight-bearing articular portion of distal tibia with or without anesthesia; without manipulation…"]]
        
        self.codesICDArray = [["amount":93.56,
                               "isSelected":false,
                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"],
                              ["amount":93.57,
                               "isSelected":false,
                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"],
                              ["amount":93.58,
                               "isSelected":false,
                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"],
                              ["amount":93.59,
                               "isSelected":false,
                               "detialText":"Fracture, sprain, strain, and dislocation except femur, hip, pelvis, and thigh with mcc"]]
        
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
            let amount = self.codesCPTArray?[indexPath.row]["amount"]
            cell?.lblAmount.text = "\(amount ?? 0)"
            cell?.lblDesc.text = self.codesCPTArray?[indexPath.row]["detialText"] as? String
            cell?.btnCheckBox.isSelected = self.codesCPTArray?[indexPath.row]["isSelected"] as? Bool ?? false
//            configureCell(cell: cell, forRowAt: indexPath)
            return cell!
        case .ICD:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ICDCell", for: indexPath) as? ICDTableViewCell
            let amount = self.codesICDArray?[indexPath.row]["amount"]
            cell?.lblAmount.text = "$\(amount ?? 0)"
            cell?.lblDesc.text = self.codesICDArray?[indexPath.row]["detialText"] as? String
            cell?.btnCheckBox.isSelected = self.codesICDArray?[indexPath.row]["isSelected"] as? Bool ?? false
//            configureCell(cell: cell, forRowAt: indexPath)
            return cell!
        }
        
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueCPTDetails", sender: nil)
    }
    
}
