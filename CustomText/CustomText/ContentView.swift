//
//  ContentView.swift
//  CustomText
//
//  Created by Jithin James on 2023-06-29.
//

import SwiftUI



struct ContentView: View {
    @State private var slider: String = ""
    var model1:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel()
        mod.customTextModel.inputText = ""
        mod.customTextModel.labelText = "one"
        mod.customTextModel.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.customTextModel.inputHolderText = "Enter your name"
        
        mod.customTextModel.errorImage = "globe"
        mod.customTextModel.id = "One"
        return mod
    }
    var model2:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel()
        mod.customTextModel.viewMode = .labelMode

        mod.customTextModel.inputText = ""
        mod.customTextModel.labelText = "two"
        mod.customTextModel.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.customTextModel.inputHolderText = "Enter your name"
        
        mod.customTextModel.errorImage = "globe"
        mod.customTextModel.id = "two"
        return mod
    }
    
    var model3:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel()
        mod.customTextModel.inputText = ""
        mod.customTextModel.labelText = "Three"
        mod.customTextModel.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.customTextModel.inputHolderText = "Enter your name"
        
        mod.customTextModel.errorImage = "globe"
        mod.customTextModel.id = "Three"
        return mod
    }
    var body: some View {
        HStack{
            VStack {

                RadioGroup(mod: [model1, model2, model3], callback: { st in
                    print(st.customTextModel.id)
//                    if st.customTextModel.inputText.count > 0 {
//                        st.customTextModel.borderColor = .orange
//                    }
                })
                
            }
        }.background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
