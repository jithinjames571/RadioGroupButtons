//
//  ContentView.swift
//  CustomText
//
//  Created by Jithin James on 2023-06-29.
//

import SwiftUI



struct ContentView: View {
    @State private var slider: String = ""
    var models: [C1TextErrorViewModel]?
    
    var model1:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel(isValid: { str in
            validdateText(str: str)
        })
        mod.config.inputText = ""
        mod.config.labelText = "one"
        mod.config.errorText = "There is an erro in text please check and try again"
        mod.config.inputHolderText = "Enter your name"
        
        mod.config.errorImage = "globe"
        mod.config.id = "One"
        return mod
    }
    var model2:  C1TextErrorViewModel {
        let mod = C1TextErrorViewModel(isValid: {_ in
            
            return true
        })
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
        let mod = C1TextErrorViewModel(isValid: {str in
            
            if str.count > 0 {
                return false
            }
            return true
            
        })
        mod.config.inputText = ""
        mod.config.labelText = "Three"
        mod.config.errorText = "sd slkdf ;sdlfk ;lskdf ;s;;lkdf;lk;lk;;k;kdsf ;ldsf k;ldsf wef s;lf ;;lsdk f;lks f;dlks;dfl k"
        mod.config.inputHolderText = "Enter your name"
        
        mod.config.errorImage = "globe"
        mod.config.id = "Three"
        return mod
    }
    
    func validdateText(str: String ) -> Bool {
        if str == "aaa" {
            model1.config.errorText = "first error"
            return false
        }
        if str == "aaa" {
            model1.config.errorText = "first error"
            return false
        }
        return true
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack{
                    VStack {
                        RadioGroup(models: [model1, model2, model3], callback: { selected in
                            print(selected.config.id)
                        })
                    }
                }.padding(.horizontal,16)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
