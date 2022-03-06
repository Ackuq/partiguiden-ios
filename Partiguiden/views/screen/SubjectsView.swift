import SwiftUI

struct SubjectsView: View {
    @ObservedObject var viewModel = APIViewModel(loader: ApiManager.shared.getSubjects())

    var body: some View {
        AsyncContentView(source: viewModel) {
            subjects in
            NavigationView {
                List(subjects) { subject in
                    NavigationLink(destination: StandpointsView(id: subject.id, name: subject.name)) {
                        HStack {
                            Text(subject.name).font(.body)
                        }
                    }
                }
                .navigationTitle("Ståndpunkter")
            }
        }
    }
}

struct SubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectsView()
    }
}
