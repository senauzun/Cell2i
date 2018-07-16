//
//  FourthViewController.swift
//  Cell2i
//
//  Created by sena on 9.07.2018.
//  Copyright © 2018 sena. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate  {
    var textname: String? = nil
    var month = ["Temmuz" , " Haziran " , "Mayis" , "Nisan" , " Mart " , "Subat"]
    var opa: String? = "123"
    let wsgetSuccess = Cell2iWebServiceImplService()
    
          let someImageView: UIImageView = {
            let theImageView = UIImageView()
            theImageView.image = UIImage(named: "cell2i.png")
            theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
                
                return theImageView
    }()
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as! CollectionViewCell
        let invoceInfo = wsgetSuccess.getInvoiceInfo(userId: textname! , invoiceCount: 6)
        
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0 , height: 1.0 )
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect : cell.bounds , cornerRadius : cell.contentView.layer.cornerRadius).cgPath
        
        let invoiceInfo_Split = invoceInfo.split(separator: "@")
        
        let ogeler = invoiceInfo_Split[indexPath[1]].split(separator: "_")
        cell.last_date.text! = "Invoice Date:" + String(ogeler[1])
        
        let tarih_ayrimi_Split = String(ogeler[1]).split(separator: ".")
        if(tarih_ayrimi_Split[1] == "03") {
            cell.month.text! = "MARCH INVOICE"
        }
        else if(tarih_ayrimi_Split[1] == "04") {
            cell.month.text! = "APRIL INVOICE"
        }
        else if(tarih_ayrimi_Split[1] == "05") {
            cell.month.text! = "MAY INVOICE"
        }
        else if(tarih_ayrimi_Split[1] == "06") {
            cell.month.text! = "JUN INVOICE"
        }
        else if(tarih_ayrimi_Split[1] == "07") {
            cell.month.text! = "JULY INVOICE"
        }
        else if(tarih_ayrimi_Split[1] == "08") {
            cell.month.text! = "AUGUST INVOICE"
        }
        
        cell.cost.text! = "Cost: " + String(ogeler[2])
        if(String(ogeler[3]) == "1"){
            cell.paidornot.text! = "PAID"
        }
        else{
            cell.paidornot.text! = "NOT PAID"
        }
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(someImageView) //This add it the view controller without constraints
        someImageViewConstraints()
        
        
        
        
    }
    func someImageViewConstraints() {
        
        someImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        someImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        someImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        someImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 280).isActive = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return month.count
        
    }
    @IBAction func backTurnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
