import SwiftUI

struct SubjectsView: View {
    @ObservedObject var viewModel = APIViewModel(loader: ApiManager.shared.getSubjects())
    @State var activeSubject: Int? = nil

    @Binding var showingDetailed: Bool

    var body: some View {
        AsyncContentView(source: viewModel) {
            subjects in
            NavigationView {
                List(subjects) { subject in
                    let activeBinding = Binding<Bool>(
                        get: { showingDetailed && activeSubject == subject.id },
                        set: {
                            if $0 == false {
                                showingDetailed = false
                                activeSubject = nil
                            } else {
                                showingDetailed = true
                                activeSubject = subject.id
                            }
                        }
                    )
                    NavigationLink(destination: StandpointsView(id: subject.id, name: subject.name), isActive: activeBinding) {
                        HStack {
                            Text(subject.name).font(.body)
                        }
                    }
                }
                .navigationTitle("Ståndpunkter")
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct SubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectsView(showingDetailed: .constant(true))
    }
}
