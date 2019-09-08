//
//  CPTDetailViewController.swift
//  LZCoder
//
//  Created by Sheshnath on 06/03/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit
import SwiftyJSON

class CPTDetailViewController: UIViewController {
    
    var codesCPTArray:JSON?
    var codesICDArray:JSON?
    var detailCodeArray:JSON?
    var selectedCode = ""
    var selectedCodeDesc = ""
    
    @IBOutlet weak var collectionViewCPT: UICollectionView!
    @IBOutlet weak var collectionViewICD: UICollectionView!
    @IBOutlet weak var lblCodeName: UILabel!
    @IBOutlet weak var lblCodeDetails: UILabel!
    
    var selectedCodeType = CodeType.CPT

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCodeDetails.text = selectedCodeDesc
        getCodeDetailFromAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func getCodeDetailFromAPI() {
        var fileName = ""
        switch selectedCodeType {
        case .CPT:
            fileName = "47570"
        case .ICD:
            fileName = "35351"
        }
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                detailCodeArray = jsonObj["CPTDetails"]
                switch selectedCodeType {
                case .CPT:
                    self.lblCodeName.text = "CPT Code: \(jsonObj["SearchWith"].stringValue)"
                case .ICD:
                    self.lblCodeName.text = "ICD-10 Code: \(jsonObj["SearchWith"].stringValue)"
                }
                print("jsonData:\(jsonObj)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
//        CodeNetwork().getCodesDetails(code: "47570") { (response) in
//            if (response.result.error == nil){
//                print(response)
//            }else{
//                print(response.result.error)
//            }
//        }

    }

}

extension CPTDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectedCodeType {
        case .CPT:
            return self.detailCodeArray?.count ?? 0
        case .ICD:
            return self.detailCodeArray?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.collectionViewCPT {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CPTColCell", for: indexPath) as? DetailViewCell
            //            configureCell(cell: cell, forItemAt: indexPath)
            let object = self.detailCodeArray![indexPath.row]
            let amount = object["FacTotal"].stringValue
            cell?.lblAmount.text = "$\(amount)"
            cell?.lblDesc.text = object["StatusCode"].stringValue
            return cell!
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ICDColCell", for: indexPath) as? DetailViewCell
            //            configureCell(cell: cell, forItemAt: indexPath)
            let object = self.detailCodeArray![indexPath.row]
            let amount = object["FacTotal"].stringValue
            cell?.lblAmount.text = "$\(amount)"
            cell?.lblDesc.text = object["MultProc"].stringValue
            return cell!
        }
        
    }
    
    func configureCell(cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 5, height: collectionView.frame.size.height)
    }
    
}
