import SwiftUI

struct About: View {
    var body: some View {
        ScrollView {
            Text("Git Watch")
                .bold()
                .font(.system(size: 18))

            Divider().padding(.vertical, 4)
            
            Text("Git Watch is a GitHub client app for watchOS. It is a SwiftUI app that uses GitHub's REST API and OAuth authentication.").font(.system(size: 12)).foregroundColor(.gray)
            
            Divider().padding(.vertical, 4)

            HStack {
                Text("Authors").font(.system(size: 16)).bold()
                Spacer()
            }.padding(.bottom, 4)
            
            HStack {
                UserImage(url: "https://github.com/iberatkaya.png?size=150", width: 25, height: 25).padding(.trailing, 2)
                VStack {
                    Text("I. Berat Kaya").font(.system(size: 13)).foregroundColor(.gray)
                    Text("@iberatkaya").font(.system(size: 13)).bold()
                }
                Spacer()
            }.padding(.bottom, 2)
            
            HStack {
                UserImage(url: "https://github.com/stelselim.png?size=150", width: 25, height: 25).padding(.trailing, 2)
                VStack {
                    Text("Selim Üstel").font(.system(size: 13)).foregroundColor(.gray)
                    Text("@stelselim").font(.system(size: 13)).bold()
                }
                Spacer()
            }.padding(.bottom, 6)
            
            HStack {
                Text("© 2021 IBKStel Apps").font(.system(size: 13)).foregroundColor(.gray)
                Spacer()
            }.padding(.bottom, 2)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
