//
//  GirisViewController.swift
//  deneme
//
//  Created by BarisOdabasi on 21.03.2021.
//

import UIKit
import Firebase

class GirisViewController: UIViewController {

    //MARK: - UI Elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    //MARK: - Actions
    @IBAction func kayitOlButton(_ sender: Any) {
        
        if emailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: sifreTextField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "HATA!", messageInput: error?.localizedDescription ?? "HATA")
                } else {
                    self.performSegue(withIdentifier: "toZikirVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "HATA!", messageInput: "Kullanıcı Adı Veya Şifre Hatalı!")
        }
    }
    
    
    @IBAction func girisYapButton(_ sender: Any) {
        
        if emailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: sifreTextField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "HATA", messageInput: error?.localizedDescription ?? "HATA")
                } else {
                    self.performSegue(withIdentifier: "toZikirVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "HATA!", messageInput: "Kullanıcı adı veya şifre hatalı!")
        }
       
    }
    
    //MARK: - Alert
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
