//
//  KaydetTableViewController.swift
//  deneme
//
//  Created by BarisOdabasi on 21.03.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class KaydetTableViewController: UITableViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var zikirAdiTextField: UITextField!
    @IBOutlet weak var zikirSayiTextField: UITextField!
    
    //MARK: - Properties
    let user = Auth.auth().currentUser
    lazy var userId:String = {
        return self.user!.uid
    }()
    
    var zikirIdArray = [String]()
    var zikirAdiArray = [String]()
    var zikirSayiArray = [String]()

    var sayi = ""
    var zikir = ""
    var id = ""
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        zikirSayiTextField.text = sayi
        zikirAdiTextField.text = zikir
        
        getDataFromFirestore()
        }
    
    //MARK: - Functions
    
    func getDataFromFirestore() {
            let fireStoreDatabase = Firestore.firestore()
                fireStoreDatabase.collection("Zikir").document(userId).collection("Zikir").addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("HATAAAAAAAAA")
                } else {
                    if snapshot?.isEmpty != true && (snapshot?.count)! > 0 {
                        
                        for document in snapshot!.documents {
                            if let zikirId = document.documentID as? String {
                                self.zikirIdArray.append(zikirId)
                            }
                         }
                        self.tableView.reloadData()
                    }
                }
            }
       }
    
    //MARK: - Actions
    
    @IBAction func kaydetButton(_ sender: Any) {
        
        let db = Firestore.firestore()
            db.collection("Zikir").document(userId).collection("Zikir").document().setData(["ZikirAdı": self.zikirAdiTextField.text!, "ZikirSayi": self.zikirSayiTextField.text!], merge: true) { (error) in
            if error != nil {
                print("TAB3 kaydet button errorrr !!!")
            }
                self.dismiss(animated: true, completion: nil)
        }
        
    }
 
    @IBAction func iptalButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
    




