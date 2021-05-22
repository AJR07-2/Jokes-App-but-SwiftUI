import Foundation

struct User {
    var uid: String
    var displayName: String
    var email: String
    var guest = false
    init(email: String, displayName: String, uid: String){
        if(email == "" && displayName == "" && uid == ""){
            self.guest = true
            self.email = ""
            let generatedID = UUID()
            self.displayName = "Guest \(generatedID)"
            self.uid = "\(generatedID)"
        }
        self.email = email
        self.displayName = displayName
        self.uid = uid
    }
}
