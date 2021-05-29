/*//
//  Post.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 6/4/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Post: UITableViewCell {
    var id: String = ""
    
    //details on post
    @IBOutlet var Number: UILabel!
    @IBOutlet var Username: UILabel!
    @IBOutlet var ProfilePic: UIImageView!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    //rating
    @IBOutlet var upvote: UIButton!
    @IBOutlet var downvote: UIButton!
    @IBOutlet weak var votes: UILabel!
    
    //joke itself
    @IBOutlet var Joke: UILabel!
    @IBOutlet weak var jokeImage: UIImageView!
    @IBOutlet weak var revealPunchLine: UIButton!
    @IBOutlet weak var punchLine: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkVoted()
        if (FirebaseAuth.Auth.auth().currentUser == nil){
            favouriteButton.isHidden = true
            upvote.isHidden = true
            downvote.isHidden = true
            votes.isHidden = true
        }else{
            favouriteButton.isHidden = false
            upvote.isHidden = false
            downvote.isHidden = false
            votes.isHidden = false
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //button press reactions
    @IBAction func favourite(_ sender: Any) {
        
    }
    
    @IBAction func upvoteClicked(_ sender: Any) {
        vote(add: 1)
    }

    @IBAction func downvoteClicked(_ sender: Any) {
        vote(add: -1)
    }
    
    @IBAction func RevealPunchLine(_ sender: Any) {
        revealPunchLine.isHidden = true
        punchLine.isHidden = false
        punchLine.alpha = 0
        UIView.animate(withDuration: 3) {
            self.punchLine.alpha = 1
        }
    }
    
    func vote(add: Int){
        var initialVote:Int = 0
        if(upvote.alpha == 0.5 && downvote.alpha == 0.5){
            initialVote = 0
        } else if(upvote.alpha == 1 && downvote.alpha == 0.5){
            initialVote = 1
        }else if(downvote.alpha == 1 && upvote.alpha == 0.5){
            initialVote = -1
        }
        
        print(downvote.alpha, upvote.alpha)
        
        //upvote personal data
        FirebaseFirestore.Firestore.firestore().collection("Posts").document(id).collection("RatingHistory").document(FirebaseAuth.Auth.auth().currentUser?.uid as! String).setData([
            "Contributions": add
        ])
        checkVoted()
        
        //update the upvote and downvote overall data
        FirebaseFirestore.Firestore.firestore().collection("Posts").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID == id){
                        var data = document.data()
                        //change the initial vote data
                        print(initialVote)
                        if(initialVote == 1){
                            data["Upvotes"] = (data["Upvotes"] as! Int) - 1
                        } else{
                            data["Downvotes"] = (data["Downvotes"] as! Int) - 1
                        }
                        //change votes accordingly
                        if(add == -1){
                            data["Downvotes"] = (data["Downvotes"] as! Int) + 1
                        }else if (add == 1){
                            data["Upvotes"] = (data["Upvotes"] as! Int) + 1
                        }
                        FirebaseFirestore.Firestore.firestore().collection("Posts").document(id).setData(data)
                        votes.text = "\((data["Upvotes"] as! Int) - (data["Downvotes"] as! Int))"
                    }
                }
            }
        }
    }
    
    func checkVoted(){
        FirebaseFirestore.Firestore.firestore().collection("Posts").document(id).collection("RatingHistory").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID == FirebaseAuth.Auth.auth().currentUser?.uid){
                        if(document.data()["Contributions"] == nil) {
                            break
                        }
                        if(document.data()["Contributions"] as! Int == 1){
                            upvote.alpha = 1
                            downvote.alpha = 0.5
                        }else if(document.data()["Contributions"] as! Int == -1){
                            upvote.alpha = 0.5
                            downvote.alpha = 1
                        } else{
                            upvote.alpha = 0.5
                            downvote.alpha = 0.5
                        }
                        break
                    }
                }
            }
        }
    }
}
*/
