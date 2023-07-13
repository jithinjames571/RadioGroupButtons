//
//  ContentView.swift
//  CustomText
//
//  Created by Jithin James on 2023-06-29.
//

import SwiftUI



struct ContentView: View {
    var one:  CustomTextErrorConfig
    var two:  CustomTextErrorConfig
    var three:  CustomTextErrorConfig
    
    init() {
        one = CustomTextErrorConfig(id: "one")
        two = CustomTextErrorConfig(id: "two")
        three = CustomTextErrorConfig(id: "three")
          
        one.viewMode = .labelMode
        one.inputText = ""
        one.labelText = "first"
        one.bottonLabelText = "second"

        two.viewMode = .textMode
        two.inputText = ""
        two.labelText = "two"
        two.errorText = "There is an erro in text please check and try again"
        two.inputHolderText = "Enter your name"
        two.errorImage = "globe"
        two.isValid = validdateText
        two.inputKeyBoardType = .decimalPad

        
        three.inputText = ""
        three.labelText = "three"
        three.errorText = "There is an erro in text please check and try again"
        three.inputHolderText = "Enter your name"
        three.errorImage = "globe"
        three.isValid = validdateText

        
    }


    
    func validdateText(str: String ) -> Bool {
        if str == "aaa" {
            two.errorText = "first error"
            return false
        }
        if str == "bbb" {
            two.errorText = "sec error"
            return false
        }
        return true
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack{
                    VStack {
                        RadioGroup(models: [one, two, three], callback: { selected in
                            print(selected.id)
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
