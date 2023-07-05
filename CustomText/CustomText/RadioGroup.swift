import SwiftUI



struct RadioGroup<Model>: View where Model: C1TextErrorViewModelProvider  {
    
    var mod: [Model]
    @State var selectedModel: Model?
    let callback: (Model) -> ()

    var body: some View {
        HStack{
            VStack {
                ForEach(1...mod.count, id:\.self) { no in
                    let item = mod[no - 1 ]
                    
                        RadioButton(content: {
                            C1CustomTextError(viewModel: item)
                        },
                                    callback: radioGroupCallback,
                                    tag: item.customTextModel.id,
                                    isMarked: selectedModel?.customTextModel.id == item.customTextModel.id,
                                    model: item)
                    
                }
                
            }
        }.background(.gray)
    }
    
    func radioGroupCallback(id: Model) {
        selectedModel = id
        callback(id)
    }
}

struct RadioGroup_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 


struct RadioButton<Content: View, Model: C1TextErrorViewModelProvider>: View  {
    @ViewBuilder var content: Content
    let callback: (Model)->()
    let tag: String
    var isMarked: Bool {
        didSet {
         //   model.customTextModel.isSelected = isMarked
        }
    }
    let model: Model
    
  var body: some View {
    Button(action:{
        self.callback(model)
        model.customTextModel.isSelected = isMarked
    }) {
        content
    }
    .buttonStyle(.plain)
  }
}
