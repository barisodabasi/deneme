//
//  MenuViewController.swift
//  deneme
//
//  Created by BarisOdabasi on 11.04.2021.
//

import UIKit
import AudioToolbox

class MenuViewController: UIViewController {

    //MARK: - UI Elements
    
    //Butonları içinde tutan view'lar
    @IBOutlet weak var sesView: UIView!
    @IBOutlet weak var titresimView: UIView!
    @IBOutlet weak var geceModuView: UIView!
    @IBOutlet weak var temaView: UIView!
    @IBOutlet weak var akilliDokunmaView: UIView!
    @IBOutlet weak var bildirimView: UIView!
    @IBOutlet weak var dilView: UIView!
    @IBOutlet weak var paylasView: UIView!
    
    //Tıklanan butonun kendisi, renk vs değiştirmek için outlet...
    @IBOutlet weak var sesButton: UIButton!
    @IBOutlet weak var titresimButton: UIButton!
    @IBOutlet weak var geceModuButton: UIButton!
    @IBOutlet weak var temaButton: UIButton!
    @IBOutlet weak var akilliDokunmaButton: UIButton!
    @IBOutlet weak var bildirimlerButton: UIButton!
    @IBOutlet weak var dilButton: UIButton!
    @IBOutlet weak var paylasButton: UIButton!
    
    //Tıklanan butonun açıklama kısmı, renk vs değiştirmek için outlet...
    @IBOutlet weak var descriptionSesButton: UIButton!
    @IBOutlet weak var descriptionTitresim: UIButton!
    @IBOutlet weak var descriptionGeceModu: UIButton!
    @IBOutlet weak var descriptionTema: UIButton!
    @IBOutlet weak var descriptionAkilliDokunma: UIButton!
    @IBOutlet weak var descriptionBildirimler: UIButton!
    
    
    //MARK: - Properties
    var soundOn = true
    
    
         
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
}
    
    //MARK: - Actions
    
    //TouchUpInside şeklinde butonları bağlayıp animasyonlu hale getirmek. Ve hangi butona basılıyorsa onun seçili(açık veya kapalı durumda) olduğunu kullanıcıya göstermek.
    @IBAction func touchUpButton(_ button: UIButton) {
        let buttonBackGround: UIView
        
        switch button {
        case sesButton:
            buttonBackGround = sesView
            if soundOn {
                sesButton.tintColor = .yellow
                descriptionSesButton.tintColor = .yellow
                descriptionSesButton.setTitle("Ses Açık", for: .normal)
            } else {
                sesButton.tintColor = .white
                descriptionSesButton.tintColor = .white
                descriptionSesButton.setTitle("Ses Kapalı", for: .normal)
            }
            soundOn.toggle()
        case titresimButton:
            buttonBackGround = titresimView
            if soundOn {
                titresimButton.tintColor = .yellow
                descriptionTitresim.tintColor = .yellow
                descriptionTitresim.setTitle("Titreşim Açık", for: .normal)
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {
                    print("titreşim açık !")
                }
            } else {
                titresimButton.tintColor = .white
                descriptionTitresim.tintColor = .white
                descriptionTitresim.setTitle("Titreşim Kapalı", for: .normal)
            }
            soundOn.toggle()
        case geceModuButton:
            buttonBackGround = geceModuView
            if soundOn {
                geceModuButton.tintColor = .yellow
                descriptionGeceModu.tintColor = .yellow
                descriptionGeceModu.setTitle("Gece Modu Açık", for: .normal)
            } else {
                geceModuButton.tintColor = .white
                descriptionGeceModu.tintColor = .white
                descriptionGeceModu.setTitle("Gece Modu Kapalı", for: .normal)
            }
            soundOn.toggle()
        case temaButton:
            buttonBackGround = temaView
            if soundOn {
                temaButton.tintColor = .yellow
                descriptionTema.tintColor = .yellow
                descriptionTema.setTitle("Tema 1", for: .normal)
            } else {
                temaButton.tintColor = .white
                descriptionTema.tintColor = .white
                descriptionTema.setTitle("Tema 2", for: .normal)
            }
            soundOn.toggle()
        case akilliDokunmaButton:
            buttonBackGround = akilliDokunmaView
            if soundOn {
                akilliDokunmaButton.tintColor = .yellow
                descriptionAkilliDokunma.tintColor = .yellow
                descriptionAkilliDokunma.setTitle("Akıllı Dokunma Açık", for: .normal)
            } else {
                akilliDokunmaButton.tintColor = .white
                descriptionAkilliDokunma.tintColor = .white
                descriptionAkilliDokunma.setTitle("Akıllı Dokunma Kapalı", for: .normal)
            }
            soundOn.toggle()
        case bildirimlerButton:
            buttonBackGround = bildirimView
            if soundOn {
                bildirimlerButton.tintColor = .yellow
                descriptionBildirimler.tintColor = .yellow
                descriptionBildirimler.setTitle("Bildirimler Açık", for: .normal)
            } else {
                bildirimlerButton.tintColor = .white
                descriptionBildirimler.tintColor = .white
                descriptionBildirimler.setTitle("Bildirimler Kapalı", for: .normal)
            }
            soundOn.toggle()
        case dilButton:
            buttonBackGround = dilView
        case paylasButton:
            buttonBackGround = paylasView
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackGround.alpha = 1
            buttonBackGround.transform = CGAffineTransform(scaleX: 1, y: 1)
            button.transform = .identity
        }) { (_) in
            buttonBackGround.transform = .identity
        }
}
    
    @IBAction func touchDownButton(_ button: UIButton) {
        // Butonları touchDown şeklinde bağlayarak animasyon oluşturmak
        
        let buttonBackGround: UIView
        
        switch button {
        case sesButton:
            buttonBackGround = sesView
        case titresimButton:
            buttonBackGround = titresimView
        case geceModuButton:
            buttonBackGround = geceModuView
        case temaButton:
            buttonBackGround = temaView
        case akilliDokunmaButton:
            buttonBackGround = akilliDokunmaView
        case bildirimlerButton:
            buttonBackGround = bildirimView
        case dilButton:
            buttonBackGround = dilView
        case paylasButton:
            buttonBackGround = paylasView
        default:
            return
        }
        UIView.animate(withDuration: 0.25) {
            buttonBackGround.alpha = 0.3
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }

    //Sayfa geri tuşu
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
       
    }
    
    // Kullanıcının dil seçme butonu
    @IBAction func dilButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Dil Seçin", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let dilAction = UIAlertAction(title: "Türkçe", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(dilAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //Kullanıcının uygulamayı paylaşma butonu, uygulamanın linki olmadığı için örnek olarak apple.com yapıldı.
    @IBAction func paylasButton(_ sender: UIButton) {
        guard let url = URL(string: "https://apple.com") else {return}
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
