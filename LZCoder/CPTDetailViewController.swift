//
//  CPTDetailViewController.swift
//  LZCoder
//
//  Created by Sheshnath on 06/03/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit

class CPTDetailViewController: UIViewController {
    
    var codesCPTArray:[[String:Any]]?
    var codesICDArray:[[String:Any]]?
    
    @IBOutlet weak var collectionViewCPT: UICollectionView!
    @IBOutlet weak var collectionViewICD: UICollectionView!
    
    var selectedCodeType = CodeType.CPT

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
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

extension CPTDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch selectedCodeType {
        case .CPT:
            return self.codesCPTArray?.count ?? 0
        case .ICD:
            return self.codesICDArray?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.collectionViewCPT {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CPTColCell", for: indexPath) as? DetailViewCell
            //            configureCell(cell: cell, forItemAt: indexPath)
            let amount = self.codesCPTArray?[indexPath.row]["amount"]
            cell?.lblAmount.text = "\(amount ?? 0)"
            cell?.lblDesc.text = self.codesCPTArray?[indexPath.row]["detialText"] as? String
            return cell!
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ICDColCell", for: indexPath) as? DetailViewCell
            //            configureCell(cell: cell, forItemAt: indexPath)
            let amount = self.codesICDArray?[indexPath.row]["amount"]
            cell?.lblAmount.text = "$\(amount ?? 0)"
            cell?.lblDesc.text = self.codesICDArray?[indexPath.row]["detialText"] as? String
            return cell!
        }
        
    }
    
    func configureCell(cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/3 - 5, height: collectionView.frame.size.height)
        
    }
    
    
    
}
