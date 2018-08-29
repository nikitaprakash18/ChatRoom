//
//  LoginViewController.swift
//  ChatInterfaceApp
//
//  Created by NikitaPrakash Patil on 8/20/18.
//  Copyright © 2018 NikitaPrakash Patil. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate{
    
    //Forget IBoutlets
    @IBOutlet weak var forgetView: UIView!
    @IBOutlet weak var forgetImage: UIImageView!
    @IBOutlet weak var forgetLabel: UILabel!
    @IBOutlet weak var forgetEmailField: UITextField!
    @IBOutlet weak var ResetButton: UIButton!
    
    
    //signUP IBoutlets
    @IBOutlet weak var signupProfilename: UITextField!
    @IBOutlet weak var signUplabel: UILabel!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var signUpConPassword: UITextField!
    @IBOutlet weak var signUpRegister: UIButton!
    
    
    //login IBoutlets
    @IBOutlet weak var profilename: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var chatlabel: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var passwordimage: UIImageView!
    @IBOutlet weak var passHint: UIButton!
    @IBOutlet weak var forgetpasswordbutton: UIButton!
    
    let alertValue = ""
    var errorMessage = ""
    let button = UIButton(type: UIButtonType.custom)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //delegates
        self.username.delegate = self
        self.password.delegate = self
        self.profilename.delegate = self
        self.signupProfilename.delegate = self
        self.signUpUsername.delegate = self
        self.signupPassword.delegate = self
        self.signUpConPassword.delegate = self
        self.forgetEmailField.delegate = self
        
        UIView.animate(withDuration: 2) {
            self.username.alpha = 1
            self.password.alpha = 1
            self.chatlabel.alpha = 1
            self.userimage.alpha = 1
            self.passwordimage.alpha = 1
            self.passHint.alpha = 1
            self.profilename.alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //validation
        if((password.text?.count)! < 6){
            alert(alertValue: 1)
        }
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func alertButton(_ sender: Any) {
        alert(alertValue: 1)
        
    }
    
    //Login Action
    @IBAction func loginButton(_ sender: Any) {
        
        if self.username.text == "" || self.password.text == "" {
            alert(alertValue: 2)
        } else {
            
            Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
                
                if error == nil {
                    AppSettings.displayName = self.profilename.text //self.signupProfilename.text!
                  //  Auth.auth().signInAnonymously(completion: nil)
                } else {
                    self.errorMessage = (error?.localizedDescription)!
                    self.alert(alertValue: 3)
                }
            }
        }
        
    }
    
    
    @IBAction func createAccountViewPageButton(_ sender: Any) {
        
        let views = (frontView: self.loginView, backView: self.signUpView)
        
        // set a transition style transitionCurlUp
        let transitionOptions = UIViewAnimationOptions.transitionCurlUp
        
        UIView.transition(with: self.view, duration: 1.0, options: transitionOptions, animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.view.addSubview(views.backView)
            
        }, completion: { finished in
            UIView.animate(withDuration: 2) {
                self.signUplabel.alpha = 1
                self.signUpUsername.alpha = 1
                self.signupPassword.alpha = 1
                self.signUpConPassword.alpha = 1
                self.signUpRegister.alpha = 1
                self.signupProfilename.alpha = 1
            }
            
        })
        
        
    }
    //To create a new account
    @IBAction func RegisterAccount(_ sender: Any) {
        if signUpUsername.text == "" || signupProfilename.text == ""  {
            alert(alertValue: 2)
        }else if (signupPassword.text?.count)! < 6{
            alert(alertValue: 1)
        }else if signupPassword.text !=  signUpConPassword.text{
            alert(alertValue: 4)
        }else {
         
            Auth.auth().createUser(withEmail: signUpUsername.text!, password: signupPassword.text!) { (user, error) in
                
                if error == nil {
                    AppSettings.displayName = self.signupProfilename.text!
                   // Auth.auth().signInAnonymously(completion: nil)
                } else {

                    self.errorMessage = (error?.localizedDescription)!
                    self.alert(alertValue: 3)
                }
            }
        }
        
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        
        //self.forgetView.isHidden = false
        UIView.animate(withDuration: 2) {
            self.forgetImage.alpha = 1
            self.forgetView.alpha = 1
            self.forgetLabel.alpha = 1
            self.forgetEmailField.alpha = 1
            self.ResetButton.alpha = 1
        }
        
    }
    
    //To reset Password
    @IBAction func ResetPasswordActipn(_ sender: Any) {
        
        if self.forgetEmailField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.forgetEmailField.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success!"
                    message = "Password reset email sent."
                    self.forgetEmailField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
        self.forgetView.isHidden = true
    }
    
    
    
    //Alert View
    func alert(alertValue: Int){
        
        switch alertValue {
            
        case 1:
            let alertController = UIAlertController(title: "Error", message: "Password should be atleast 6 Characters", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        case 2:
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        case 3:
            let alertController = UIAlertController(title: "Error", message:  self.errorMessage, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        case 4:
            let alertController = UIAlertController(title: "Error", message:  "Password is incoorect", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        default: break
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

