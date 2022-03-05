//
//  LoadingView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-03.
//

import SwiftUI

struct LoadingView: View {
    let timer = Timer.publish(every: 1.6, on: .main, in: .common).autoconnect()
    
    @State var leftOffset: CGFloat = -100
    @State var rightOffset: CGFloat = 100
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .offset(x: leftOffset)
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 1), value: leftOffset)
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .offset(x:  leftOffset )
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 1).delay(0.2), value: leftOffset)
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .offset(x: leftOffset)
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 1).delay(0.4), value: leftOffset)
        }.onReceive(timer) { (_) in
            swap(&self.leftOffset, &self.rightOffset)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
