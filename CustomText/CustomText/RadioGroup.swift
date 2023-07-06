import SwiftUI



struct RadioGroup<Model>: View where Model: C1TextErrorViewModelProvider  {
    
    var mod: [Model]
    @State var selectedModel: Model?
    let callback: (Model) -> ()
    @FocusState var isEmailFocused: Bool

    var body: some View {
        HStack{
            VStack {
                ForEach(1...mod.count, id:\.self) { no in
                    let item = mod[no - 1 ]
                        RadioButton(callback: radioGroupCallback,
                                    tag: item.customTextModel.id,
                                    isMarked: getCellState(item: item),
                                    model: item)
                    
                }
                
            }
        }.background(.gray)
    }
    
    func getCellState(item: Model) -> CellState {
        if item.customTextModel.inputText.count > 0 {
            return .error
        }
        return selectedModel?.customTextModel.id == item.customTextModel.id ? .selected : .unselected
    }

    func radioGroupCallback(id: Model) {
        selectedModel = nil
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
    var isMarked: CellState 
    let model: Model
    @FocusState var isEmailFocused: Bool 

  var body: some View {
          Button(action:{
              isEmailFocused = true
        self.callback(model)
    }) {
        //model.customTextModel.isSelected = true
        C1CustomTextError(viewModel: model, cellState: .constant(isMarked), callback: callback )
    }
    .buttonStyle(.plain)
  }
}

