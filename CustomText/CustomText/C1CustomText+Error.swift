//
//  C1CustomText+Error.swift
//  CustomText
//
//  Created by Jithin James on 2023-06-29.
//

import SwiftUI

struct C1CustomTextError<Model>: View where Model: C1TextErrorViewModelProvider {
    @ObservedObject var viewModel: Model

    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.customTextModel.labelText ?? "").frame(alignment: .leading)
                    .foregroundColor(viewModel.customTextModel.labelTextColor)
                    .padding(EdgeInsets(top: viewModel.customTextModel.labelText?.count ?? 0 > 0 ? 8:0 , leading: 16, bottom: viewModel.customTextModel.labelText?.count ?? 0 > 0 ? 8:0, trailing: 16))
                
                if viewModel.customTextModel.viewType == .text {
                    TextField(viewModel.customTextModel.inputHolderText ?? "", text: $viewModel.customTextModel.inputText)
                        .frame(height: 50, alignment: .leading)
                        .cornerRadius(4)
                        .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(viewModel.customTextModel.inputTextBorderColor, lineWidth: 1)
                            ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
                    HStack( alignment: .top, spacing: 0) {
                        Image(systemName: viewModel.customTextModel.errorImage ?? "")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .padding(.top, 8)
                        Text(viewModel.customTextModel.errorText ?? "").frame( alignment: .leading)
                            .foregroundColor(viewModel.customTextModel.errorTextColor)
                            .padding((EdgeInsets(top: viewModel.customTextModel.errorText?.count ?? 0 > 0 ? 8:0 , leading: 10, bottom: viewModel.customTextModel.errorText?.count ?? 0 > 0 ? 8:0 , trailing: 0)))
                    }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    
                } else {
                    Text(viewModel.customTextModel.labelText ?? "").frame(alignment: .leading)
                        .foregroundColor(.green)
                        .background(.yellow)
                        .padding(EdgeInsets(top: viewModel.customTextModel.labelText?.count ?? 0 > 0 ? 8:0 , leading: 16, bottom: viewModel.customTextModel.labelText?.count ?? 0 > 0 ? 8:0, trailing: 16))
                }


            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(viewModel.customTextModel.backgoundColor)
            .cornerRadius(4)
            .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(viewModel.customTextModel.borderColor, lineWidth: 2)
                ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
               

        }
    }
}

struct C1CustomTextErrorPreviews: PreviewProvider {

    static var previews: some View {
        let model =  C1TextErrorViewModel()
        model.customTextModel.inputText = ""
        model.customTextModel.labelText = "sd"
        model.customTextModel.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        model.customTextModel.inputHolderText = "Enter your name"

        model.customTextModel.errorImage = "globe"

        return  C1CustomTextError(viewModel: model)
        
    }
}

class C1TextErrorViewModel: ObservableObject, C1TextErrorViewModelProvider {

    func saveEditedFruit() {
        customTextModel.labelText =  customTextModel.inputText

    }
    
    @Published var customTextModel: CustomTextErrorModel = CustomTextErrorModel(id: "")



}

protocol C1TextErrorViewModelProvider: ObservableObject {
    var customTextModel: CustomTextErrorModel {get set}
    func saveEditedFruit()
}


struct CustomTextErrorModel {
    enum ViewType {
        case label
        case text
    }
    var id: String
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                backgoundColor = .red
            } else {
                backgoundColor = .blue

            }
        }
    }
    var labelText: String?
    var inputText: String
    var errorText: String?
    var inputHolderText: String?

    var errorImage: String?
    
    var inputTextColor: Color = .black
    var inputTextBorderColor: Color = .black
    var inputTextBgColor: Color = .white
    var labelTextColor: Color = .black
    var backgoundColor: Color = .green
    var borderColor: Color = .black
    var errorTextColor: Color = .red

    var viewType: ViewType = .text

    var borderWidth: Float = 1

    init(inputText: String = "", id: String) {
        self.inputText = inputText
        self.id = id
    }
    
}
