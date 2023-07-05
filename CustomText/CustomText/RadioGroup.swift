import SwiftUI



struct RadioGroup<Model>: View where Model: C1TextErrorViewModelProvider  {
    
    var mod: [Model]
    @State var selectedId: String = ""
    let callback: (String) -> ()

    var body: some View {
        HStack{
            VStack {
                ForEach(1...mod.count, id:\.self) { no in
                    let item = mod[no - 1 ]
                    
                        RadioButton(content: {
                            C1CustomTextError(viewModel: item)
                        }, callback: radioGroupCallback, id: "")
                    
                }
                
            }
        }.background(.gray)
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct RadioGroup_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 
struct Tag {
    var tag: String
}

struct RadioButton<Content: View>: View {
    @ViewBuilder var content: Content

    let callback: (String)->()
    let id: String
    
  var body: some View {
    Button(action:{
        self.callback(self.id)
    }) {
        content
    }
    .buttonStyle(.plain)
  }
}
