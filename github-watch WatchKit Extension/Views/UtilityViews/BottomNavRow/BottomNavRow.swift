import SwiftUI

struct BottomNavRow: View {
    var buttonClick: (() -> Void)?
    var loading: Bool

    var body: some View {
        HStack {
            if !loading {
                Button(action: {
                    buttonClick?()
                }, label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                })
            }
        }
    }
}

struct BottomNavRow_Previews: PreviewProvider {
    @State static var loading = false

    static var previews: some View {
        BottomNavRow(loading: loading)
    }
}
