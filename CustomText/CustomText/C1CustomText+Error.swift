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

struct C1CustomText<Model>: View where Model: C1TextErrorViewModelProvider {
    @ObservedObject var viewModel: Model
    @FocusState private var isFocused: Bool
    let callback: (Model)->()?
    
    let hPadding = 16.0
    let vPadding = 16.0
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.labelText)
                    .frame(alignment: .leading)
                    .foregroundColor(viewModel.cellState.theme.labelTextColor)
                    .padding(EdgeInsets(top: viewModel.labelText.count > 0 ? vPadding/2:0 , leading: hPadding, bottom: viewModel.labelText.count > 0 ? vPadding/2:0, trailing: hPadding))
                
                    Text(viewModel.labelText).frame(alignment: .leading)
                        .foregroundColor(viewModel.cellState.theme.labelTextColor)
                        .padding(EdgeInsets(top: viewModel.labelText.count > 0 ? vPadding/2:0 , leading: hPadding, bottom: viewModel.labelText.count > 0 ? vPadding/2:0, trailing: hPadding))
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(viewModel.cellState.theme.backgoundColor)
            
            .cornerRadius(4)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 4)
                    .stroke(viewModel.cellState.theme.borderColor, lineWidth: 2)
            ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }
        
        .onChange(of: viewModel.cellState, perform: {newValue in
            isFocused = newValue == .selected && viewModel.viewMode == .textMode
        })
    }
}



struct C1CustomTextFieldError<Model>: View where Model: C1TextErrorViewModelProvider {
    @ObservedObject var viewModel: Model
    @FocusState private var isFocused: Bool
    let callback: (Model)->()?
    
    let hPadding = 16.0
    let vPadding = 16.0
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.labelText)
                    .frame(alignment: .leading)
                    .foregroundColor(viewModel.cellState.theme.labelTextColor)
                    .padding(EdgeInsets(top: viewModel.labelText.count > 0 ? vPadding/2:0 , leading: hPadding, bottom: viewModel.labelText.count > 0 ? vPadding/2:0, trailing: hPadding))
                
                    TextField(viewModel.inputHolderText, text: $viewModel.inputText)
                        .onSubmit({
                            print("user clicked on return")
                            self.callback(viewModel)
                        })
                        .focused($isFocused)
                        .keyboardType(viewModel.inputKeyBoardType)
                        .frame(height: 50, alignment: .leading)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(viewModel.cellState.theme.inputTextBorderColor, lineWidth: 1)
                        )
                        .background(.white)
                        .cornerRadius(4)
                        .padding(EdgeInsets(top: 0, leading: hPadding, bottom: hPadding, trailing: hPadding))
                if viewModel.cellState == .error {
                        HStack( alignment: .top, spacing: 0) {
                            Image(systemName: viewModel.errorImage)
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            Text(viewModel.errorText)
                                .frame( alignment: .leading)
                                .foregroundColor(viewModel.cellState.theme.labelTextColor)
                                .padding((EdgeInsets(top: 0 , leading: 10, bottom: vPadding , trailing: 0)))
                        }.padding(EdgeInsets(top: 0, leading: hPadding, bottom: 0, trailing: hPadding))
                                        
                }
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(viewModel.cellState.theme.backgoundColor)
            
            .cornerRadius(4)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 4)
                    .stroke(viewModel.cellState.theme.borderColor, lineWidth: 2)
            ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            
        }
        
        .onChange(of: viewModel.cellState, perform: {newValue in
            isFocused = newValue == .selected && viewModel.viewMode == .textMode
        })
    }
}

enum ViewMode {
    case labelMode
    case textMode
}
protocol C1TextErrorViewModelProvider: ObservableObject {
    
    var id: String {get set}
    var labelText: String {get set}
    var bottonLabelText: String {get set}
    var inputText: String {get set}
    var errorText: String {get set}
    var inputHolderText: String {get set}
    var inputKeyBoardType: UIKeyboardType {get set}
    var errorImage: String {get set}
    
    var selected: Theme? {get set}
    var unselected: Theme? {get set}
    var error: Theme? {get set}
    
    var cellState: CellState {get set}
    var viewMode: ViewMode {get set}
    var isValid: ((String)-> Bool)? {get set}
    
}
class CustomTextErrorConfig: ObservableObject, C1TextErrorViewModelProvider {
 
    var id: String
    @Published var labelText: String = ""
    @Published var bottonLabelText: String = ""
    @Published var inputText: String = ""
    @Published var errorText: String = ""
    @Published var inputHolderText: String = ""
    
    @Published var inputKeyBoardType: UIKeyboardType = .default
    @Published var errorImage: String = ""
    
    @Published var inputTextColor: Color = .black
    @Published var inputTextBorderColor: Color = .black
    @Published var labelTextColor: Color = .black
    @Published var backgoundColor: Color = .green
    @Published var borderColor: Color = .black
   
    @Published var selected: Theme?
    @Published var unselected: Theme?
    @Published var error: Theme?
    @Published var cellState: CellState = .unselected

    
    var viewMode: ViewMode = .textMode
    
    var isValid: ((String)-> Bool)?
    
    init(id: String) {
        self.id = id
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
