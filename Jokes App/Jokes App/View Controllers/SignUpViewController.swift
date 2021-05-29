//
//  SignUpViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 8/4/21.
//

import SwiftUI
import Firebase

struct SignUpViewController: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 40, content: {
            HStack {
                VStack{
                    Button("Post", action:{
                            self.presentationMode.wrappedValue.dismiss()
                    })
                    Button("Post", action:{
                            self.presentationMode.wrappedValue.dismiss()
                    })
                }
                VStack{
                    Button("Post", action:{
                            self.presentationMode.wrappedValue.dismiss()
                    })
                    Button("Post", action:{
                            self.presentationMode.wrappedValue.dismiss()
                    })
                }
            }
            List(){
                
            }
        })
    }
    /*
    
    func SignUp() {
        if(username == "" || email == "" || password == ""){
            let alert = UIAlertController(title: "Error", message: "One of the fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
            print("Unable to sign user up due to empty field")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseFirestore.Firestore.firestore().collection("User").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let otherUsername = document.data()["username"]
                    if(otherUsername as! String == username.text!){
                        let alert = UIAlertController(title: "Error", message: "Username has been used before", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
                        print("Unable to sign user up due to empty field")
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
            }
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: {[weak self] result, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Account creation failed")
                let alert = UIAlertController(title: "Error", message: "Account Creaation Failed, possibly due to incorrect password", preferredStyle: .alert)
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
        FirebaseFirestore.Firestore.firestore().collection("User").document(userID!).setData([
            "username": username.text!,
            "email": email.text!,
            "uid": FirebaseAuth.Auth.auth().currentUser!.uid,
        ])
        
        self.dismiss(animated: true, completion: nil)
    }*/
}

struct SignUpViewController_Preview: PreviewProvider {
    static var previews: some View {
        SignUpViewController()
    }
}
