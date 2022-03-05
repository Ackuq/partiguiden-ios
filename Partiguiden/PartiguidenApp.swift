import SwiftUI

@main
struct PartiguidenApp: App {
    var body: some Scene {
        WindowGroup {
            TabNavigator()
        }
    }
}

struct PartiguidenApp_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigator()
            .preferredColorScheme(.light)
        TabNavigator()
            .preferredColorScheme(.dark)
    }
}
