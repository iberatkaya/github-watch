import URLImage

import SwiftUI

struct UserImage: View {
    let url: String
    let width: CGFloat
    let height: CGFloat

    init(url: String, width: CGFloat = 120, height: CGFloat = 120) {
        self.url = url
        self.width = width
        self.height = height
    }

    var body: some View {
        URLImage(url: URL(string: url)!,
                 inProgress: { progress -> Text in
                     if let progress = progress {
                         return Text(String(format: "%.0f", progress * 100) + "%")
                     }
                     else {
                         return Text("Loading...")
                     }
                 },
                 failure: { error, retry in
                     VStack {
                         Text(error.localizedDescription)
                         Button("Retry", action: retry)
                     }
                 },
                 content: { image in
                     image
                         .resizable()
                         .scaledToFill()
                         .frame(width: width, height: height)
                         .clipShape(Circle())
                 })
    }
}

struct UserImage_Previews: PreviewProvider {
    static var previews: some View {
        UserImage(url: "https://avatars.githubusercontent.com/u/14101776?v=4")
    }
}
