import FASwiftUI
import SwiftUI

struct About: View {
    var body: some View {
        ScrollView {
            Text("Git Watch")
                .bold()
                .font(.system(size: 18))

            Divider().padding(.vertical, 4)

            Text("Git Watch is a GitHub client app for watchOS. It is a SwiftUI app that uses GitHub's REST API and OAuth authentication. Feel free to contribute at iberatkaya/github-watch.")
                .font(.system(size: 12))
                .foregroundColor(.gray)

            Divider().padding(.vertical, 4)

            HStack {
                Text("Authors").font(.system(size: 16)).bold()
                Spacer()
            }.padding(.bottom, 4)

            VStack {
                HStack {
                    UserImage(url: "https://github.com/iberatkaya.png?size=150", width: 25, height: 25).padding(.trailing, 4)

                    Text("I. Berat Kaya").font(.system(size: 13)).foregroundColor(.gray)

                    Spacer()
                }

                HStack {
                    Spacer()
                    FAText(iconName: "github", size: 16).padding(.trailing, 2)
                    Text("@iberatkaya").font(.system(size: 10)).bold()
                }.padding(.bottom, 2)

                HStack {
                    Spacer()
                    FAText(iconName: "linkedin", size: 16).padding(.trailing, 2)
                    Text("ibrahim-berat-kaya").font(.system(size: 10)).bold()
                }
            }.padding(.bottom, 16)

            VStack {
                HStack {
                    UserImage(url: "https://github.com/stelselim.png?size=150", width: 25, height: 25).padding(.trailing, 4)

                    Text("Selim Üstel").font(.system(size: 13)).foregroundColor(.gray)

                    Spacer()
                }

                HStack {
                    Spacer()
                    FAText(iconName: "github", size: 16).padding(.trailing, 2)
                    Text("@stelselim").font(.system(size: 10)).bold()
                }.padding(.bottom, 2)

                HStack {
                    Spacer()
                    FAText(iconName: "linkedin", size: 16).padding(.trailing, 2)
                    Text("selimustel").font(.system(size: 10)).bold()
                }
            }.padding(.bottom, 12)

            HStack {
                Text("© 2021 IBKStel Apps").font(.system(size: 13)).foregroundColor(.gray)
                Spacer()
            }.padding(.bottom, 2)
        }
        .padding(.horizontal, 8)
        .navigationTitle("About")
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
