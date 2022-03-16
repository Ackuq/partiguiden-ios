import SwiftUI

struct SubjectsView: View {
    @StateObject var viewModel = APIViewModel(loader: APIManager.getSubjects())
    
    var body: some View {
        NavigationView {
            AsyncContentView(source: viewModel) {
                subjects in
                List(subjects) { subject in
                    NavigationLink(destination: StandpointsView(id: subject.id, name: subject.name)) {
                        Text(subject.name)
                    }
                }
            }
            .navigationTitle("Ståndpunkter")
        }
        .navigationViewStyle(.stack)
    }
}

struct SubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectsView()
    }
}
