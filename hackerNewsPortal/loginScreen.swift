import SwiftUI
struct loginScreen: View {
    var body: some View {
        VStack{
            Text("HackerNews").bold().font(Font.title).multilineTextAlignment(.leading).foregroundColor(Color.init(red: 0.5, green: 0.2, blue: 0.5))
            
            List{
                Text("Login ID")
.textInputAutocapitalization(/*@START_MENU_TOKEN@*/.words/*@END_MENU_TOKEN@*/)
                Text("Password")
            }
        }.frame(alignment: .center)
    }
}

struct loginScreen_Previews: PreviewProvider {
    static var previews: some View {
        loginScreen()
    }
}
