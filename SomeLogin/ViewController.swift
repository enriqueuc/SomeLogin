//
//  ViewController.swift
//  SomeLogin
//
//  Created by Ing. Enrique Ugalde on 24/07/16.
//  Copyright © 2016 Ing. Enrique Ugalde. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

//Google Sign in add GIDSignInDelegate, GIDSignInUIDelegate
//Para hacer el boton de google sign in es necesario una view y añadirle la clase GIDSignInButton medidas 125x45
class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // for google sign in
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func bt(sender: AnyObject) {
    }
    
    
    //for google sign in
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let error = error{
            print(error.localizedDescription)
            return
        }
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
        FIRAuth.auth()?.signInWithCredential(credential, completion: {
            (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            print("acceso con google")
        })
    }

    //for google sign in
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        if let error = error{
            print(error.localizedDescription)
            return
        }
        try! FIRAuth.auth()!.signOut()
    }
}

