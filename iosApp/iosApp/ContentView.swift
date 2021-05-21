import SwiftUI
import shared

struct ContentView: View {
            
    let greeting: Greeting = Greeting()
    
    var body: some View {
        EmptyView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
