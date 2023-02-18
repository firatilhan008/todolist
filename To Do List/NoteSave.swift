//
//  toVC2.swift
//  To Do List
//
//  Created by Fırat İlhan on 1.02.2023.
//

import UIKit
import CoreData

class NoteSave: UIViewController {
    
    
    @IBOutlet weak var noteText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let klavyeKapat = UITapGestureRecognizer(target: self, action: #selector(kapatt))
        view.addGestureRecognizer(klavyeKapat)
        
    }

    @objc func kapatt() {
        view.endEditing(true)
    }
    
    @IBAction func addButton(_ sender: Any) {
       
        if noteText.text?.isEmpty == false {
            noteSave()
        
        } else {
            makeAlert()
        }
        
    }
    
    
    func noteSave() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //bu satır ezber
        let kayit = appDelegate.persistentContainer.viewContext // bu satır ezber
        
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: kayit)
        
          
        //Attributes
        newNote.setValue(UUID(), forKey: "id")
        newNote.setValue(noteText.text!, forKey: "note")
        
        
        do {
            try  kayit.save()
            print("başarılı kayıt")
            
        } catch {
            print("Hata")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newNote"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        noteText.text = ""
    }
    func makeAlert() {
        let alert = UIAlertController(title: "Uyarı", message: "Not yazınız!!!", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil)
        
    }
}
