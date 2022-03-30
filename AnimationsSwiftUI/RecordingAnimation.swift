//
//  RecordingAnimation.swift
//  AnimationsSwiftUI
//
//  Created by Ivan Voloshchuk on 30/03/22.
//

import SwiftUI

struct RecordingAnimation: View {
    
    @State var isTapped = false
    @State var animationON = false
    @State var textAnim = false
    let grad1 = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    let grad2 = Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
    let hapticMedium = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack{
            if isTapped{
                Text("Recording...")
                    .font(.system(size: 30))
                    .padding(.top,80)
                    .opacity(textAnim ? 0 : 1)
                    .onAppear{
                        withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true).speed(2.5)) {
                            textAnim.toggle()
                        }
                    }
            }
            else{
                Text("Tap to record")
                    .font(.system(size: 30))
                    .padding(.top,80)
            }
            Spacer()
            Button{
                isTapped.toggle()
                hapticMedium.impactOccurred()
                
            } label:{
                
                ZStack{
                    
                    Circle()
                        .frame(width: isTapped ? 160 : 100, height: isTapped ? 160 : 100)
                        .foregroundStyle(
                            isTapped ?
                                .linearGradient(
                                    colors: [grad1, grad2],
                                    startPoint: .trailing,
                                    endPoint: .leading
                                )
                            :
                                .linearGradient(
                                    colors: [Color.primary, Color.primary],
                                    startPoint: .trailing,
                                    endPoint: .leading
                                )
                        )
                        .opacity(isTapped ? 1 : 0.8)
                        .hueRotation(.degrees(animationON ? -50 : 50))
                        .onAppear{
                            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true).speed(2.0)) {
                                animationON.toggle()
                            }
                        }
                    Circle()
                        .stroke(.purple,lineWidth: 3)
                        .scaleEffect(animationON ? 0.6 : 0.5)
                        .opacity(isTapped ? 0.5 : 0)
                    Circle()
                        .foregroundColor(.purple)
                        .frame(width: 180, height: 180)
                        .opacity(isTapped ? 0.5 : 0.0)
                        .scaleEffect(animationON ? 1.1 : 1)
                    Image(systemName: "mic")
                        .resizable()
                        .foregroundColor(.white)
                        .opacity(isTapped ? 0.5 :1)
                        .frame(width: 20, height: 30)
                        .scaleEffect(isTapped ? 1.6 : 1)
                }
            }
            Spacer()
        }
    }
}

struct RecordingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RecordingAnimation()
    }
}
