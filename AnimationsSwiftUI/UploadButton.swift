//
//  UploadButton.swift
//  AnimationsSwiftUI
//
//  Created by Ivan Voloshchuk on 31/03/22.
//

import SwiftUI

struct UploadButton: View {
    @State var complete: Bool = false
    @State var inProgress: Bool = false
    @State var arrow : Double = 0
    
    var body: some View {
        ZStack{
            Color.orange
                .opacity(0.5)
            AsyncButton(isComplete: complete, action: {
                inProgress = true
                arrow = 90
                // Start Async Task (Download, Submit, etc)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        complete = true
                    }
                }
            }) {
                Image(systemName: "arrow.up")
                    .foregroundColor(.green)
                //               Text(complete || inProgress ? "" : "􀄫")
            }
        }.ignoresSafeArea()
    }
}


struct AsyncButton_Previews: PreviewProvider {
    static var previews: some View {
        UploadButton()
    }
}


struct AsyncButton<Content: View>: View {
    
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
                    progressView()
                        .foregroundColor(.green)
                        .frame(width: 20, height: 20)
                } else if isComplete {
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .center)
                        .foregroundColor(.white)
                    
                }
                else {
                    content
    
                }
            }
            .frame(maxWidth: isComplete || inProgress ? 50 : 100, maxHeight: isComplete  || inProgress ? 50 : nil, alignment: .center)
            .padding(.vertical, isComplete  || inProgress ? 0 : 12)
            .foregroundColor(.white)
            .background( isComplete ? .green : .white)
            .cornerRadius(25)
            .font(Font.body.weight(.semibold))
            .padding(.all, 20)
        })
        
    }
    
    
}

struct progressView : View{
    
    @State private var animON = false
    
    var body: some View{
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [30, 40], dashPhase: animON ? -100 : 100))
            .onAppear{
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false).speed(4.5)) {
                    animON.toggle()
                }
            }
        
    }
    
}
