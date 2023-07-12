import SwiftUI

struct RadioGroup<Model>: View where Model: C1TextErrorViewModelProvider  {
    
    @State var models: [Model]
    @State private var selectedModel: Model?
    let callback: (Model) -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            
            ForEach(1...models.count, id:\.self) { no in
                let model = models[no - 1 ]
                RadioButton(callback: radioGroupCallback,
                            model: model)
            }
        }
//        .toolbar(content: {
//            ToolbarItem(placement: .keyboard, content: {
//            Text("Title")
//         })})
    }
    
    private func getCellState(model: Model) -> Binding<CellState> {
        var state: CellState = .unselected
        let binding = Binding(
            get: { state },
            set: { state = $0 }
        )
        if !(model.isValid?(model.inputText) ??  true) {
            state = .error
            model.cellState = state
            
            return binding
        }
        state = selectedModel?.id == model.id ? .selected : .unselected
        model.cellState = state
        return binding
    }
    
    func radioGroupCallback(id: Model) {
        if selectedModel?.id != id.id {
            selectedModel?.inputText = ""
        }
        for item in models {
            if (item.id == id.id ) {
                
                if !(id.isValid?(id.inputText) ??  true) {
                    item.cellState = .error

                } else {
                    item.cellState = .selected
                }
                
            }
            else {
                item.cellState = .unselected
            }
        }

        selectedModel = nil
        selectedModel = id
        callback(id)
    }
}

struct RadioButton<Model: C1TextErrorViewModelProvider>: View  {
    let callback: (Model)->()
    let model: Model
    
    var body: some View {
        Button(action:{
            self.callback(model)
        }) {
            if model.viewMode == .textMode {
                C1CustomTextFieldError(viewModel: model, callback: callback )
            } else {
                C1CustomText(viewModel: model, callback: callback )
                
            }
        }.padding()
            .buttonStyle(.plain)
        
    }
    
}

