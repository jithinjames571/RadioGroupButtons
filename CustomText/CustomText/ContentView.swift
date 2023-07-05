//
//  ContentView.swift
//  CustomText
//
//  Created by Jithin James on 2023-06-29.
//

import SwiftUI



struct ContentView: View {
    @State private var slider: String = ""
    var model:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel()
        mod.customTextModel.inputText = ""
        mod.customTextModel.labelText = "sd"
        mod.customTextModel.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.customTextModel.inputHolderText = "Enter your name"
        
        mod.customTextModel.errorImage = "globe"
        return mod
    }
    var body: some View {
        HStack{
            VStack {

                RadioGroup(mod: [model,model], callback: {_ in })
                
//                Button(action: {}) {
//                    
//                    C1CustomTextError(viewModel: model)
//
//                }
//                Button(action: {}) {
//                    
//                    C1CustomTextError(viewModel: model)
//
//                }
                
                

            }
        }.background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
