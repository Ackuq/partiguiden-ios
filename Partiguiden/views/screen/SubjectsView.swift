import SwiftUI

struct SubjectsView: View {
    @State var subjects = [SubjectListEntry]()
    
    var body: some View {
        NavigationView {
            if !subjects.isEmpty {
                List(subjects) { subject in
                    NavigationLink(destination: StandpointsView(id: subject.id, name: subject.name)) {
                        HStack {
                            Text(subject.name).font(.body)
                        }
                    }
                    
                }
                .navigationTitle("Ståndpunkter")
                .navigationBarTitleDisplayMode(.large)
            } else {
                LoadingView()
            }
            
        }
        .onAppear(perform: {
            ApiManager.shared.getSubjects { (subjects) in
                self.subjects = subjects
            }
        })
    }
}

struct SubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectsView()
    }
}
