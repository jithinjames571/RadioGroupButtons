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
        mod.config.inputText = ""
        mod.config.labelText = "one"
        mod.config.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.config.inputHolderText = "Enter your name"
        
        mod.config.errorImage = "globe"
        mod.config.id = "One"
        return mod
    }
    var model2:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel()
        mod.config.viewMode = .labelMode

        mod.config.inputText = ""
        mod.config.labelText = "two"
        mod.config.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.config.inputHolderText = "Enter your name"
        
        mod.config.errorImage = "globe"
        mod.config.id = "two"
        return mod
    }
    
    var model3:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel()
        mod.config.inputText = ""
        mod.config.labelText = "Three"
        mod.config.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.config.inputHolderText = "Enter your name"
        
        mod.config.errorImage = "globe"
        mod.config.id = "Three"
        return mod
    }
    var body: some View {
        HStack{
            VStack {

                RadioGroup(mod: [model1, model2, model3], callback: { st in
                    print(st.config.id)
//                    if st.config.inputText.count > 0 {
//                        st.config.borderColor = .orange
//                    }
                })
                
            }
        }.padding(.horizontal,16)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
