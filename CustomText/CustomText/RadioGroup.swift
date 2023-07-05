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
                        RadioButton(callback: radioGroupCallback,
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

 


struct RadioButton<Model: C1TextErrorViewModelProvider>: View  {
    let callback: (Model)->()
    let tag: String
    var isMarked: Bool
    let model: Model
    
  var body: some View {
          Button(action:{
        self.callback(model)
    }) {
        //model.customTextModel.isSelected = true
        C1CustomTextError(viewModel: model,isSelected: .constant(isMarked))
    }
    .buttonStyle(.plain)
  }
}
