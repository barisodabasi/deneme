//
//  ZikirViewController.swift
//  deneme
//
//  Created by BarisOdabasi on 18.03.2021.
//

import UIKit
import Firebase

class ZikirViewController: UIViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var hiddenStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Properties
    var currentNumber = 0
    var zikirAdiArray = [String]()
    var zikirIdArray = [String]()
    
    let user = Auth.auth().currentUser
    lazy var userId:String = {
        return self.user!.uid
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenStackView.isHidden = true
        
        getDataFromFirestore()
    }
    
    //MARK: - Functions
    
    //Fonksiyon tetiklendiğinde şu anki sayı 1 artacak ve Firestore'a data göndericek, anlık sayıyı Label'da göstericek.
    func sayi() {
        currentNumber += 1
       
        let db = Firestore.firestore()
        db.collection("AnlikZikir").document(userId).setData(["ZikirSayı": self.numberLabel.text!])
        
        numberLabel.text = String(currentNumber)
   }
    
    func getDataFromFirestore() {
        //Firestore'dan data çekmek
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("AnlikZikir").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Zikir View Controller Error !!!")
            } else {
                if snapshot?.isEmpty != true {
                    
                    for document in snapshot!.documents {
                       // let documentID = document.documentID
                        
                        if let anlikzikir = document.get("ZikirSayı") as? String {
                            self.zikirAdiArray.append(anlikzikir)
                            self.numberLabel.text = anlikzikir
                        }
                        if let zikirId = document.documentID as? String {
                            self.zikirIdArray.append(zikirId)
                    }
                }
            }
        }
    }
}
    //MARK: - Actions
    
    @IBAction func zikirlerimButton(_ sender: Any) {
        performSegue(withIdentifier: "toZikirList", sender: nil)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        // Butona her basıldığında sayı() fonksiyonu tetiklenicek ve hiddenStackView mevcut sayıyı gösterip kaydet butonu açılacak.
        sayi()
        if currentNumber >= 1 {
            hiddenStackView.isHidden = false
            self.descriptionLabel.text = " \(self.currentNumber) adet zikir kayıt et"
            
            
        }
    }
    
    @IBAction func restartButton(_ sender: Any) {
        // Kullanıcı zikiri sıfırlamak istediğinde alert çıkıcak silmeyi onayladığında sıfırlanıcak.
        if currentNumber == 0 {
            let alert2 = UIAlertController(title: "UYARI", message: "Sayacınız zaten sıfır", preferredStyle: UIAlertController.Style.alert)
            let okButton2 = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
            alert2.addAction(okButton2)
            self.present(alert2, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "DİKKAT", message: "Sayacı Sıfırlamak istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.alert)
            let cancelButton = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: nil)
            let okButton = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { (action) in
                self.currentNumber = 0
                self.numberLabel.text = String(self.currentNumber)
                self.hiddenStackView.isHidden = true
                self.saveButton.isHidden = false
            }
                
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
         }
 }
    
    @IBAction func backButton(_ sender: Any) {
        
        // Geri butonuna bastıgında mevcut zikir sayısı azalacak
        if currentNumber > 0 {
            currentNumber -= 1
            numberLabel.text = String(currentNumber)
            descriptionLabel.text = " \(currentNumber) adet zikir kayıt et"
        }
        
        if currentNumber == 0 {
            hiddenStackView.isHidden = true
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "saveSegue", sender: nil)
        
    }
    
    //Kaydet Butonuna Bastıgında Güncel Zikir Sayısıyla Kaydet Ekranına Gitmek İçin Yazıldı...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue" {
            let kaydetVC = segue.destination as? UINavigationController
            let editZikir = kaydetVC?.topViewController as! KaydetTableViewController
            editZikir.sayi = numberLabel.text!
        }
    }
    
    //TableView'da bir satırda devam ete bastıgında oradaki bilgilerle zikir ekranına döner
    @IBAction func unwindFromZikirList(_ segue: UIStoryboardSegue) {
        
        guard segue.identifier == "devamEtUnwind",
        let sourceViewController = segue.source as? ZikirListTableViewController else {return}
        
        let newZikirAdi = sourceViewController.zikirAdiArray
        let newZikirSayi = sourceViewController.zikirSayiArray
        let zikirID = sourceViewController.zikirIdArray
        
       if let selectedIndexPath = sourceViewController.tableView.indexPathForSelectedRow {
            hiddenStackView.isHidden = false
            descriptionLabel.text! = "Zikir : \(newZikirAdi[selectedIndexPath.row])"
            numberLabel.text = newZikirSayi[selectedIndexPath.row]
            currentNumber = Int(numberLabel.text!)!
            saveButton.isHidden = true
        
      
       // db.collection("Zikir").document(userId).collection("Zikir").document(zikirID[selectedIndexPath.row]).updateData(["ZikirSayi": self.numberLabel.text!])
        }
    }
}
