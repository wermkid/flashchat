import SwiftUI
import WebKit
struct DetailView: View {
    let url:String?
    var body: some View {
        WebView(url: url)    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url:"https://www.google.com")
    }
}


