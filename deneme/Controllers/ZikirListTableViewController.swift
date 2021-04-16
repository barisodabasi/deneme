//
//  ZikirListTableViewController.swift
//  deneme
//
//  Created by BarisOdabasi on 28.03.2021.
//

import UIKit
import Firebase

class ZikirListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    
    //Kullanıcının kendi id'si
    let user = Auth.auth().currentUser
    lazy var userId:String = {
        return self.user!.uid
    }()
    
    var zikirAdiArray = [String]()
    var zikirSayiArray = [String]()
    var zikirIdArray = [String]()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
        
        
        
    }
    
  //MARK: - Functions
    
    
    func getDataFromFirestore() {
       //Firestore'dan datayı almak ve array'in içine atıyorum.
            let fireStoreDatabase = Firestore.firestore()
            fireStoreDatabase.collection("Zikir").document(userId).collection("Zikir").addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("HATAAAAAAAAA")
                } else {
                    if snapshot?.isEmpty != true && (snapshot?.count)! > 0 {
                        self.zikirAdiArray.removeAll()
                        self.zikirSayiArray.removeAll()
                        
                        for document in snapshot!.documents {
                        
                            if let zikirAdi = document.get("ZikirAdı") as? String {
                                self.zikirAdiArray.append(zikirAdi)
                            }
                            if let zikirSayi = document.get("ZikirSayi") as? String {
                                self.zikirSayiArray.append(zikirSayi)
                            }
                            if let zikirId = document.documentID as? String {
                                self.zikirIdArray.append(zikirId)
                            }
                         }
                        self.tableView.reloadData()
                    }
                }
            }
       }
   

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return zikirAdiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ZikirCell
        
        cell.zikirAdiLabel.text = zikirAdiArray[indexPath.row]
        cell.zikirSayiLabel.text = zikirSayiArray[indexPath.row]
            
       return cell
}
    
    // MARK: - Table view delegate
    // Kayıtlı zikir tablosunda zikirlerin yerini değişmek için...
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedZikirAdi = zikirAdiArray.remove(at: sourceIndexPath.row)
        let movedZikirSayi = zikirSayiArray.remove(at: sourceIndexPath.row)
        zikirAdiArray.insert(movedZikirAdi, at: destinationIndexPath.row)
        zikirSayiArray.insert(movedZikirSayi, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Editing style .delete ise kullanıcı mevcut zikiri silmek isterse ilgili indexPath Firestore'dan silinir.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let db = Firestore.firestore()
            db.collection("Zikir").document(userId).collection("Zikir").document(zikirIdArray[indexPath.row]).delete { (error) in
                if let error = error {
                    print("ERROR SİLME İSLEMİ: \(error)")
                } else {
                    /*
                    self.zikirAdiArray.remove(at: indexPath.row)
                    self.zikirSayiArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.reloadData()
 */
                }
            }
        }
    }
    
    //MARK: - Actions
    // Edit modunu aktif hale getirir veya tam tersini yapar
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
    }
    
   //MARK: - Segue
    // Kullanıcı tableView'daki Düzenle butonuna bastıgında ilgili ekrana veri aktarımıyla yönlendirilecek
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"  {
            if let button = sender as? UIButton {
                
                let position = CGPoint()
                let selectedIndexPath = tableView.indexPathForRow(at: button.convert(position, to: tableView))
                let selectedZikirAdi = zikirAdiArray[selectedIndexPath!.row]
                let selectedZikirSayi = zikirSayiArray[selectedIndexPath!.row]
                let selectedId = zikirIdArray[selectedIndexPath!.row]
                
                let navigationController = segue.destination as? UINavigationController
                let editZikir = navigationController?.topViewController as! KaydetTableViewController
                editZikir.sayi = selectedZikirSayi
                editZikir.zikir = selectedZikirAdi
                editZikir.id = selectedId
            }
        }
    }
    /*
     KaydetViewController'daki Save butonuna basınca yeni zikir eklemek veya mevcut zikiri güncellemek için yazıldı. Fakat hatalı...
     
     
    @IBAction func unwindUpdateOrAddZikir(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindUpdateOrAdd",
              let sourceViewController = segue.source as? KaydetTableViewController else {return}
    
        let newZikirAdi = sourceViewController.zikirAdiArray
        let newZikirSayi = sourceViewController.zikirSayiArray
        let zikirID = sourceViewController.zikirIdArray
        
        if let selectedIndexPath = sourceViewController.tableView.indexPathForSelectedRow {
            let db = Firestore.firestore()
            db.collection("Zikir").document(userId).collection("Zikir").document(zikirID[selectedIndexPath.row]).setData(["ZikirAdı": newZikirAdi, "ZikirSayi": newZikirSayi])
            print(zikirID)
        } else {
            let db = Firestore.firestore()
            db.collection("Zikir").document(userId).collection("Zikir").document().setData(["ZikirAdı": newZikirAdi, "ZikirSayi": newZikirSayi])
        }
    }
 */
}
