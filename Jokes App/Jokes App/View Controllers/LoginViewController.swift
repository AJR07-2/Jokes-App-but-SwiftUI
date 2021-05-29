/*
 //
//  LoginViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 8/4/21.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: Any) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email.text as! String, password: password.text as! String, completion: {[weak self]result, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: "Please check your Password or Email, and make sure the account you are logging in to has been registered before", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
                print("Unable to sign user up due to empty field")
                }))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
        })
        print("Sign in sucessful")
        let userID = FirebaseAuth.Auth.auth().currentUser?.uid
        if(userID == nil){
            return
        }
        FirebaseFirestore.Firestore.firestore().collection("User").document(userID as! String) .collection("LoginHistory").addDocument(data: [
            "Time" : Date()
        ])
        self.dismiss(animated: true, completion: nil)
    }
}

struct ContentView: View {
    var body: some View {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
