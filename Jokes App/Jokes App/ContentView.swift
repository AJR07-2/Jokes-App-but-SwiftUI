import SwiftUI
import Firebase

struct ContentView: View {
    var database = Firebase.Firestore.firestore()
    var auth = Firebase.Auth.auth()
    @State var currentUser:User?
    @State var signInActivated = false
    @State var signUpActivated = false
    
    init(){
        if(auth.currentUser == nil){
            self.currentUser = nil
        } else {
            self.currentUser = User(email: (auth.currentUser?.email)!, displayName: (auth.currentUser?.displayName!)!, uid: auth.currentUser!.uid)
        }
    }
    
    var body: some View {
        if(self.currentUser == nil){
            NavigationView{
                VStack (alignment: .center, spacing: 10, content: {
                    
                    //sign in as guest
                    Button("Sign In As Guest"){
                        auth.signInAnonymously(completion:{_,_ in
                            print("Signed in as guest")
                            self.currentUser = User(email: "", displayName: "", uid: "")
                        })
                    }
                    .padding()
                    .frame(width: 200, height: 60, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    //or
                    Text("OR")
                        .foregroundColor(.red)
                        .bold()
                    
                    //sign in button
                    Button("Sign In"){
                        signInActivated = true
                    }
                    .padding()
                    .frame(width: 200, height: 60, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    //sign up button
                    Button("Sign Up"){
                        signUpActivated = true
                    }
                    .padding()
                    .frame(width: 200, height: 60, alignment: .center)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(10)
                })
            }
            NavigationLink(
                destination: Text("Destination"),
                isActive: $signInActivated){
                
                Text("Signed in! :)")
            }
            
            NavigationLink(
                destination: Text("Destination"),
                isActive: $signUpActivated){
                
                Text("Signed in! :)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
