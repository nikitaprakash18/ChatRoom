//
//  ViewController.swift
//  ChatInterfaceApp
//
//  Created by NikitaPrakash Patil on 8/20/18.
//  Copyright © 2018 NikitaPrakash Patil. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate{
    
    //signUP IBoutlets
    @IBOutlet weak var signupProfilename: UITextField!
    @IBOutlet weak var signUplabel: UILabel!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var signUpConPassword: UITextField!
    @IBOutlet weak var signUpRegister: UIButton!
    
    
    //login IBoutlets
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var chatlabel: UILabel!
    @IBOutlet weak var userimage: UIImageView!
     @IBOutlet weak var passwordimage: UIImageView!
     @IBOutlet weak var passHint: UIButton!
     @IBOutlet weak var forgetpasswordbutton: UIButton!
    
    let transition = CircularTransition()
    let alertValue = ""
    var errorMessage = ""
    let button = UIButton(type: UIButtonType.custom)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UIView.animate(withDuration: 2) {
            self.username.alpha = 1
            self.password.alpha = 1
            self.chatlabel.alpha = 1
            self.userimage.alpha = 1
            self.passwordimage.alpha = 1
            self.passHint.alpha = 1
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
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        if self.username.text == "" || self.password.text == "" {
            
            alert(alertValue: 2)
            
        } else {
            
            Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    //self.present(vc!, animated: true, completion: nil)
                    //self.performSegue(withIdentifier: "loginToHome", sender: self)
                    
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
                //self.signupProfilename.alpha = 1
            }
            
        })
        
        
    }
    
    @IBAction func RegisterAccount(_ sender: Any) {
        //signupProfilename.text == ""
        if signUpUsername.text == ""   {
            alert(alertValue: 2)
        }else if (signupPassword.text?.count)! < 6{
            alert(alertValue: 1)
        }else if signupPassword.text !=  signUpConPassword.text{
            alert(alertValue: 4)
        }else {
          //  AppSettings.displayName = signupProfilename.text!
            Auth.auth().signInAnonymously(completion: nil)
            Auth.auth().createUser(withEmail: signUpUsername.text!, password: signupPassword.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    AppSettings.displayName = " nik" //self.signupProfilename.text!
                    Auth.auth().signInAnonymously(completion: nil)
                    
                  //  if let user = Auth.auth().currentUser { //
                    //    let VC = self.storyboard?.instantiateViewController(withIdentifier: "profileshow") as! ProfileViewController
                      //  VC.currentUser1 = user
                        
                        //self.performSegue(withIdentifier: "showNav", sender: VC)
                        
                        //print(user.displayName)
                        // self.navigationController?.pushViewController(VC, animated: true)
                        //let vc = ProfileViewController(nibName: "SecondaryViewController", bundle: nil)
                        //vc.text = "Next level blog photo booth, tousled authentic tote bag kogi"
                        //let vc = ProfileViewController(currentUser: user)
                        
                        //showNav
                        //NavigationController(vc)
                  //  }
                    // let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    //  self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    self.errorMessage = (error?.localizedDescription)!
                    self.alert(alertValue: 3)
                }
            }
        }
        
    }
    
 /*   //forget password segue and animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  let secondVC = segue.destination as! ForgetPasswordViewController
        //secondVC.transitioningDelegate = self
        //secondVC.modalPresentationStyle = .custom
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = forgetpasswordbutton.center
        //transition.circleColor = forgetpasswordbutton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = forgetpasswordbutton.center
        transition.circleColor = forgetpasswordbutton.backgroundColor!
        
        return transition
    }*/
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
}

