/*
x//  ViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 3/4/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet var postJokes:UITableView!
    
    var jokes:[[String: Any]] = []
    
    var timer:Timer = Timer()
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        
        //load table view data
        let nib =  UINib(nibName: "Post", bundle: nil)
        postJokes.register(nib, forCellReuseIdentifier: "Post")
        postJokes.delegate = self
        postJokes.dataSource = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true, block: { [self] (_) in
            fetchPosts()
        })
        fetchPosts()
    }
    
    //other button functions
    @IBAction func Sync(_ sender: Any) {
        fetchPosts()
    }
    
    //Presenting other view controllers
    @IBAction func AddPost(_ sender: Any) {
        if(FirebaseAuth.Auth.auth().currentUser == nil){
            let alert = UIAlertController(title: "You are not signed In", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Sign In", comment: "Default action"), style: .cancel, handler: { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                if let settingsViewController = storyboard.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController{
                    self.present(settingsViewController, animated: true, completion: nil)
                }else{
                    print("Something went wrong :(")
                }
            }))
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let postViewController = storyboard.instantiateViewController(withIdentifier: "Post") as? PostViewController{
            self.present(postViewController, animated: true, completion: nil)
        }else{
            print("Something went wrong :(")
        }
    }
    
    @IBAction func showProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let setting = storyboard.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController{
            self.present(setting, animated: true, completion: nil)
        }else{
            print("Something went wrong :(")
        }
    }
    
    @IBAction func API(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let API = storyboard.instantiateViewController(withIdentifier: "API") as? APIViewController{
            self.present(API, animated: true, completion: nil)
        }else{
            print("Something went wrong :(")
        }
    }
    
    
    //fetching post data from firebase
    func fetchPosts(){
        let database = FirebaseFirestore.Firestore.firestore()
        
        database.collection("Posts").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                jokes = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    jokes.append(data)
                }
            }
            postJokes.reloadData()
        }
    }
}

//table view delegate and dataSource
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show profile of person later
        print("cell is tapped")
        return
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(jokes.count == 0){
            postJokes.isHidden = true
        }else{
            postJokes.isHidden = false
        }
        return jokes.count
    }
    
    //customise each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postJokes.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! Post
        let data = jokes[indexPath[1]]
        
        cell.Username.text = "\(data["User"] as! String)"
        cell.Number.text = "\(indexPath[1] + 1)"
        cell.Joke.text = "\(data["Joke"] as! String)"
        cell.punchLine.text = "\(data["PunchLine"] as! String)"
        cell.votes.text = "\((data["Upvotes"] as! Int) - (data["Downvotes"] as! Int))"
        cell.id = "\(data["DocID"] as! String)"
        
        //UI Improvementsr
        cell.Joke.layer.cornerRadius = 10
        cell.Joke.layer.masksToBounds = true
        cell.punchLine.layer.cornerRadius = 10
        cell.punchLine.layer.masksToBounds = true
        
        
        //time conversion
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"

        
        let date:Timestamp = data["DateCreated"] as! Timestamp
        let convertedDate : Date = date.dateValue()
        let reConvertedDate = dateFormatter.string(from: convertedDate)
        
        cell.Time.text = "\(reConvertedDate)"
        cell.checkVoted()
        return cell
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
