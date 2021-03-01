import SwiftUI
import DateHelper
struct MiniCommitView: View {
    let commit: Commit
    
    var body: some View {
        VStack{
            Text(commit.message ?? "")
                .bold()
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.bottom, 4)
            Text(commit.date?.toStringWithRelativeTime() ?? "")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding(.bottom, 4)
            HStack{
                if let avatar = commit.owner?.avatarUrl {
                    UserImage(url: avatar, width: 28, height: 28).padding(.trailing, 4)
                }
                
                Text(commit.owner?.username ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.leading, 4)
                Spacer()
            }
            

        }
    }
}

struct MiniCommitView_Previews: PreviewProvider {
    static var previews: some View {
        MiniCommitView(commit: Commit(message: "Initial Commit", owner: ProfileUser(username:"stelselim",avatarUrl: "https://yt3.ggpht.com/ytc/AAUvwnioHoNurvLcjTKv2ZVhV8Nn5jroh9At5HZixuMxhA=s176-c-k-c0x00ffffff-no-rj"), date: Date()))
    }
}
