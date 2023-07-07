import SwiftUI



struct RadioGroup<Model>: View where Model: C1TextErrorViewModelProvider  {
    
    var mod: [Model]
    @State var selectedModel: Model?
    let callback: (Model) -> ()
    @FocusState var isEmailFocused: Bool
    
    var body: some View {
        ForEach(1...mod.count, id:\.self) { no in
            let item = mod[no - 1 ]
            RadioButton(callback: radioGroupCallback,
                        tag: item.config.id,
                        isMarked: getCellState(item: item),
                        model: item)
        }
    }
    
    func getCellState(item: Model) -> Binding<CellState> {
        var state: CellState = .unselected

        let binding = Binding(
            get: { state },
            set: { state = $0 }
        )
        
        if item.config.inputText.count > 0 {
            state = .error
            return binding
        }
        
        state = selectedModel?.config.id == item.config.id ? .selected : .unselected
        return binding
    }
    
    func radioGroupCallback(id: Model) {
                if selectedModel?.config.id != id.config.id {
                    selectedModel?.config.inputText = ""
                }
        
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
    @Binding var isMarked: CellState
    let model: Model
    
    var body: some View {
        Button(action:{
            self.callback(model)
        }) {
            C1CustomTextError(viewModel: model, cellState: $isMarked, callback: callback )
        }
        .buttonStyle(.plain)
    }
}

