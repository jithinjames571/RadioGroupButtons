import SwiftUI

struct RadioGroup<Model>: View where Model: C1TextErrorViewModelProvider  {
    
    var models: [Model]
    @State private var selectedModel: Model?
    let callback: (Model) -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            
            ForEach(1...models.count, id:\.self) { no in
                let model = models[no - 1 ]
                RadioButton(callback: radioGroupCallback,
                            isSelected: getCellState(model: model),
                            model: model)
            }
        }.toolbar(content: {
            ToolbarItem(placement: .keyboard, content: {
            Text("Title")
         })})
    }
    
    private func getCellState(model: Model) -> Binding<CellState> {
        var state: CellState = .unselected
        let binding = Binding(
            get: { state },
            set: { state = $0 }
        )
        if !model.config.isValid(model.config.inputText) {
            state = .error
            return binding
        }
        state = selectedModel?.config.id == model.config.id ? .selected : .unselected
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

struct RadioButton<Model: C1TextErrorViewModelProvider>: View  {
    let callback: (Model)->()
    @Binding var isSelected: CellState
    let model: Model
    
    var body: some View {
        Button(action:{
            self.callback(model)
        }) {
            if model.config.viewMode == .textMode {
                C1CustomTextFieldError(viewModel: model, cellState: $isSelected, callback: callback )
            } else {
                C1CustomText(viewModel: model, cellState: $isSelected, callback: callback )
                
            }
        }.padding()
            .buttonStyle(.plain)
        
    }
    
}

