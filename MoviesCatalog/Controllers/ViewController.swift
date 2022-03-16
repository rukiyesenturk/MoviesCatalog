//
//  ViewController.swift
//  MoviesCatalog
//
//  Created by Macbook on 11.03.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButton(_ sender: UIButton) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil{
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "You got an error, please try again!")
                }else{
                    self.performSegue(withIdentifier: "toSearch", sender: nil)
                }
            }
        }else{
            errorMessage(titleInput: "Error!", messageInput: "Enter Your Email and Password! ")
        }
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            //Kayıt olma işlemleri
            //Authantication'ı çağırabilmek için ilk önce FireBase'ı import etmem gerekiyor.
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error, Please try again!")
                }else{
                    self.performSegue(withIdentifier: "toSearch", sender: nil)
                }
            }
        }else {
            //Hata mesajı verecek
            errorMessage(titleInput: "Error", messageInput: "Enter Your Email and Password!")
        }
    }
   
    func errorMessage(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

