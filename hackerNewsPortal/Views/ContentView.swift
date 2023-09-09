import SwiftUI
import SwiftUI
import WebKit
struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        VStack{
            NavigationView {
                List(networkManager.posts){ post in
                    NavigationLink(destination: DetailView(url: post.url)) {
                        HStack {
                            VStack {
                                Image(systemName: "arrowtriangle.up.fill").imageScale(.small)
                                Text(String(post.points)).font(Font.system(size: 15))
                            }.foregroundColor(.gray)
                            Text(post.title)
                        }
                    }
                    .listStyle(.grouped)
                }
                .navigationTitle("HackerNews")
            }
            .onAppear {
                self.networkManager.fetchData()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().edgesIgnoringSafeArea(.all)
    }
}
