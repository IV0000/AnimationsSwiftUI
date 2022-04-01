//
//  PayButton.swift
//  AnimationsSwiftUI
//
//  Created by Ivan Voloshchuk on 01/04/22.
//

import SwiftUI

let yellow = Color(#colorLiteral(red: 0.9607843137, green: 0.8509803922, blue: 0.5294117647, alpha: 1))
let buttonColor = Color(#colorLiteral(red: 0.1960784314, green: 0.01568627451, blue: 0.5254901961, alpha: 1))


struct PayButton: View {
    @State var complete: Bool = false
    @State var inProgress: Bool = false
    @State var arrow : Double = 0
    
    let background = Color(#colorLiteral(red: 0.3647058824, green: 0.07450980392, blue: 0.9098039216, alpha: 1))
    
    var body: some View {
        ZStack{
            background
            CustomButton(isComplete: complete, action: {
                inProgress = true
                arrow = 90
                // Start Async Task (Download, Submit, etc)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        complete = true
                    }
                }
            }) {
                HStack{
                    Image(systemName: "creditcard")
                        .resizable()
                        .foregroundColor(yellow)
                        .frame(width:30, height : 20)
                        .padding(.leading,-5)
                    Text("Pay Now")
                        .foregroundColor(.white)
                }
            }
        }
        .ignoresSafeArea()
    }
}


struct PayButton_Previews: PreviewProvider {
    static var previews: some View {
        PayButton()
    }
}


struct CustomButton<Content: View>: View {
    
    var isComplete: Bool
    let action: ()->()
    let content: Content
    
    
    @State private var inProgress: Bool
    
    init(isComplete: Bool, action: @escaping ()->(), @ViewBuilder label: ()->Content) {
        self.action = action
        self.isComplete = isComplete
        self.content = label()
        self._inProgress = State.init(initialValue: false)
    }
    
    var body: some View {
        Button(action: {
            if !inProgress { action() }
            withAnimation(Animation.easeInOut(duration: 0.8)) {
                inProgress = true
            }
            
        }, label: {
            VStack(alignment: .trailing) {
                if inProgress && !isComplete {
                    touchID()
                        .frame(width: 10, height: 10)
                } else if isComplete {
                    completedView()
                }
                else {
                    content
                    
                }
            }
            .frame(maxWidth: isComplete || inProgress ? 150 : 170, maxHeight: isComplete  || inProgress ? 50 : 30, alignment: .center)
            .padding(.vertical, isComplete  || inProgress ? 0 : 12)
            .foregroundColor(.white)
            .background( isComplete ? buttonColor : buttonColor)
            .cornerRadius( isComplete  || inProgress ? 10 : 7 )
            .font(Font.body.weight(.semibold))
            .padding(.all, 20)
        })
        
    }
    
    
}


struct completedView : View{
    
    @State private var opac = 0.0
    @State private var offX : CGFloat = 25.0
    @State private var scale = 1.9
    
    var body: some View{
        HStack{
            
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(yellow)
                .offset(x: offX)
                .scaleEffect(scale)
            
            Text("Completed")
                .opacity(opac)
        }.onAppear{
            withAnimation(.easeOut(duration: 1.2).delay(0.2)){
                offX = 0.0
                scale = 1.0
            }
            withAnimation(.easeInOut(duration: 1.2).delay(1)){
                opac = 1.0
            }
        }
    }
}


struct touchID : View{
    
    @State private var touch = 100
    
    var body: some View{
        ZStack{
            
            Image(systemName: "faceid")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color(.systemGray3))
                .opacity(0.6)
            
            Image(systemName: "faceid")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(yellow)
                .clipShape(Rectangle().offset(y: CGFloat(touch)))
            
        }
        .onAppear() {
            withAnimation(.easeOut(duration: 1.5)){
                touch = 0
            }
        }
    }
}

