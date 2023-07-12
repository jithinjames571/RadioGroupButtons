//
//  C1CustomText+Error.swift
//  CustomText
//
//  Created by Jithin James on 2023-06-29.
//

import SwiftUI
enum CellState {
    case selected
    case unselected
    case error
}
extension CellState {
    var theme: Theme {
        switch self {
        case .selected:
            return selectedTheme()
        case .unselected:
            return unselectedTheme()
        case .error:
            return errorTheme()
        }
    }
}
protocol C1TextErrorViewModelProvider: ObservableObject {
    var config: CustomTextErrorConfig {get set}
}
struct C1CustomText<Model>: View where Model: C1TextErrorViewModelProvider {
    @ObservedObject var viewModel: Model
    @Binding var cellState: CellState
    @FocusState private var isFocused: Bool
    let callback: (Model)->()?
    
    let hPadding = 16.0
    let vPadding = 16.0
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.config.labelText)
                    .frame(alignment: .leading)
                    .foregroundColor(cellState.theme.labelTextColor)
                    .padding(EdgeInsets(top: viewModel.config.labelText.count > 0 ? vPadding/2:0 , leading: hPadding, bottom: viewModel.config.labelText.count > 0 ? vPadding/2:0, trailing: hPadding))
                
                    Text(viewModel.config.labelText).frame(alignment: .leading)
                        .foregroundColor(cellState.theme.labelTextColor)
                        .padding(EdgeInsets(top: viewModel.config.labelText.count > 0 ? vPadding/2:0 , leading: hPadding, bottom: viewModel.config.labelText.count > 0 ? vPadding/2:0, trailing: hPadding))
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cellState.theme.backgoundColor)
            
            .cornerRadius(4)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 4)
                    .stroke(cellState.theme.borderColor, lineWidth: 2)
            ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }
        
        .onChange(of: cellState, perform: {newValue in
            isFocused = newValue == .selected && viewModel.config.viewMode == .textMode
        })
    }
}



struct C1CustomTextFieldError<Model>: View where Model: C1TextErrorViewModelProvider {
    @ObservedObject var viewModel: Model
    @Binding var cellState: CellState
    @FocusState private var isFocused: Bool
    let callback: (Model)->()?
    
    let hPadding = 16.0
    let vPadding = 16.0
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.config.labelText)
                    .frame(alignment: .leading)
                    .foregroundColor(cellState.theme.labelTextColor)
                    .padding(EdgeInsets(top: viewModel.config.labelText.count > 0 ? vPadding/2:0 , leading: hPadding, bottom: viewModel.config.labelText.count > 0 ? vPadding/2:0, trailing: hPadding))
                
                    TextField(viewModel.config.inputHolderText, text: $viewModel.config.inputText)
                        .onSubmit({
                            print("user clicked on return")
                            self.callback(viewModel)
                        })
                        .focused($isFocused)
                        .keyboardType(viewModel.config.inputKeyBoardType)
                        .frame(height: 50, alignment: .leading)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(cellState.theme.inputTextBorderColor, lineWidth: 1)
                        )
                        .background(.white)
                        .cornerRadius(4)
                        .padding(EdgeInsets(top: 0, leading: hPadding, bottom: hPadding, trailing: hPadding))
                    if cellState == .error {
                        HStack( alignment: .top, spacing: 0) {
                            Image(systemName: viewModel.config.errorImage)
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            Text(viewModel.config.errorText)
                                .frame( alignment: .leading)
                                .foregroundColor(cellState.theme.labelTextColor)
                                .padding((EdgeInsets(top: 0 , leading: 10, bottom: vPadding , trailing: 0)))
                        }.padding(EdgeInsets(top: 0, leading: hPadding, bottom: 0, trailing: hPadding))
                                        
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cellState.theme.backgoundColor)
            
            .cornerRadius(4)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 4)
                    .stroke(cellState.theme.borderColor, lineWidth: 2)
            ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            
        }
        
        .onChange(of: cellState, perform: {newValue in
            isFocused = newValue == .selected && viewModel.config.viewMode == .textMode
        })
    }
}

struct C1CustomTextErrorPreviews: PreviewProvider {
    
    static var previews: some View {
        let model =  C1TextErrorViewModel(isValid: { str  in
            
            return true
        })
        model.config.inputText = ""
        model.config.labelText = "sd"
        model.config.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        model.config.inputHolderText = "Enter your name"
        
        model.config.errorImage = "globe"
        let c = FocusState()
        c.wrappedValue = true
        
        return  C1CustomText(viewModel: model, cellState: .constant(CellState.selected), callback: { id in
            
        })
        
    }
}

class C1TextErrorViewModel: ObservableObject, C1TextErrorViewModelProvider {
    @Published var config: CustomTextErrorConfig
    init(isValid: @escaping (String) -> Bool) {
        config = CustomTextErrorConfig(id: "", isValid: isValid)
    }
}

struct CustomTextErrorConfig {
    enum ViewMode {
        case labelMode
        case textMode
    }
    
    var id: String
    var labelText: String = ""
    var bottonLabelText: String = ""
    var inputText: String = ""
    var errorText: String = ""
    var inputHolderText: String = ""
    
    var inputKeyBoardType: UIKeyboardType = .default
    var errorImage: String = ""
    
    var inputTextColor: Color = .black
    var inputTextBorderColor: Color = .black
    var labelTextColor: Color = .black
    var backgoundColor: Color = .green
    var borderColor: Color = .black
    var errorTextColor: Color = .red
    
    var viewMode: ViewMode = .textMode
    
    var borderWidth: Float = 1
    
    var isValid: (String)-> Bool
    
    init(id: String, isValid: @escaping (String)-> Bool) {
        self.id = id
        self.isValid = isValid
    }
    
}

protocol Theme {
    var inputTextColor: Color {get set}
    var inputTextBorderColor: Color {get set}
    var borderColor: Color {get set}
    var labelTextColor: Color {get set}
    var backgoundColor: Color {get set}
    
}

struct selectedTheme: Theme {
    var inputTextColor: Color = .black
    
    var inputTextBorderColor: Color = .blue
    
    var borderColor: Color = .blue
    
    var labelTextColor: Color = .black
    
    var backgoundColor: Color = .blue.opacity(0.3)
}

struct unselectedTheme: Theme {
    var inputTextColor: Color = .black.opacity(0.8)
    
    var inputTextBorderColor: Color = .gray
    
    var borderColor: Color = .gray
    
    var labelTextColor: Color = .black
    
    var backgoundColor: Color = .gray.opacity(0.5)
}

struct errorTheme: Theme {
    var inputTextColor: Color = .black
    
    var inputTextBorderColor: Color = .red
    
    var borderColor: Color = .red
    
    var labelTextColor: Color = .black
    
    var backgoundColor: Color = .red.opacity(0.3)
    
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
