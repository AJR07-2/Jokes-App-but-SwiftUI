/*
//
//  SettingsViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 8/4/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SettingsViewController: UIViewController {
    @IBOutlet weak var loginView: UIStackView!
    @IBOutlet weak var userInfoView: UIStackView!
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var email: UILabel!
    
    //user info lables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if user should be signed in/signed up
        if(FirebaseAuth.Auth.auth().currentUser == nil){
            userInfoView.isHidden = true
            loginView.isHidden = false
        }else{
            userInfoView.isHidden = false
            loginView.isHidden = true
            email.text = FirebaseAuth.Auth.auth().currentUser?.email
            
            FirebaseFirestore.Firestore.firestore().collection("User").getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if (document.documentID  == FirebaseAuth.Auth.auth().currentUser?.uid){
                            let data = document.data()
                            usernameLabel.text = data["username"] as? String
                            break
                        }
                    }
                }
            }
            
        }
    }
    
    @IBAction func changeUsername(_ sender: Any) {
        FirebaseFirestore.Firestore.firestore().collection("User").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if (document.documentID  == FirebaseAuth.Auth.auth().currentUser?.uid){
                        var data = document.data()
                        data["username"] = usernameLabel.text
                        FirebaseFirestore.Firestore.firestore().collection("User").document(FirebaseAuth.Auth.auth().currentUser?.uid as! String).setData(data)
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
            userInfoView.isHidden = true
            loginView.isHidden = false
        } catch {
            let alert = UIAlertController(title: "Error", message: "An Error Ocurred", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
            print("Unable to log user out")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUserUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let signUp = storyboard.instantiateViewController(withIdentifier: "SignUp") as? SignUpViewController{
            self.present(signUp, animated: true, completion: nil)
            self.viewDidLoad()
        }else{
            print("Something went wrong :(")
        }
    }
    
    @IBAction func logUserIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let login = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController{
            self.present(login, animated: true, completion: nil)
            self.viewDidLoad()
        }else{
            print("Something went wrong :(")
        }
    }
    
    @IBAction func favourite(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let favourites = storyboard.instantiateViewController(withIdentifier: "Favourites") as? FavouritesViewController{
            self.present(favourites, animated: true, completion: nil)
        }else{
            print("Something went wrong :(")
        }
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
