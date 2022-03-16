//
//  VoteSummaryChartView.swift
//  Partiguiden
//
//  Created by Axel Pettersson on 2022-03-15.
//

import SwiftUI

struct VoteSummaryBarView: View {
    let id = UUID()
    
    var vote: String
    var color: Color
    var getWidth: (String) -> CGFloat
    @Binding var currentMarker: UUID?
    @State var showMarker = false
    
    var body: some View {
        if Int(vote)! > 0{
            ZStack {
                Rectangle()
                    .fill(color)
                    .frame(width: getWidth(vote), height: VoteSummaryChartView.height)
                    .onTapGesture {
                        if currentMarker == id {
                            currentMarker = nil
                        } else {
                            currentMarker = id
                        }
                    }
                if Int(vote)! > 7 && showMarker {
                    ChartMarkerView(content: vote, rotate: true)
                        .offset(x: 0, y: VoteSummaryChartView.height * 2)
                        .zIndex(10)
                }
            }
            .frame(height: VoteSummaryChartView.height)
            .onChange(of: currentMarker) { newValue in
                if newValue != id && showMarker {
                    withAnimation {
                        showMarker = false
                    }
                } else if (newValue == id && !showMarker) {
                    withAnimation {
                        showMarker = true
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct VoteSummaryChartView: View {
    @State var currentMarker: UUID? = nil
    @State var animate: Bool = false
    
    var votes: VoteDescriptionResponse
    var total: Double
    let width = UIScreen.main.bounds.width - CGFloat(16 * 2)
    
    init(votes: VoteDescriptionResponse) {
        self.votes = votes
        self.total = Double(votes.yes)! + Double(votes.no)! + Double(votes.refrain)! + Double(votes.abscent)!
    }
    
    static var height: CGFloat = 20
    func getWidth(value: String) -> CGFloat {
        return CGFloat((Double(value)! / total)) * width
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing){
                HStack(spacing: 0) {
                    VoteSummaryBarView(
                        vote: votes.yes,
                        color: voteColors.yes,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                    VoteSummaryBarView(
                        vote: votes.no,
                        color: voteColors.no,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                    VoteSummaryBarView(
                        vote: votes.refrain,
                        color: voteColors.refrain,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                    VoteSummaryBarView(
                        vote: votes.abscent,
                        color: voteColors.abscent,
                        getWidth: getWidth,
                        currentMarker: $currentMarker
                    )
                }
                Rectangle()
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(height: 20)
                    .frame(width: animate ? 1 : width)
            }
            .padding(.bottom, 30)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    animate = true
                }
            }
            
            ColorDescriptionView()
        }
    }
}

struct VoteSummaryChartView_Previews: PreviewProvider {
    static var previews: some View {
        VoteSummaryChartView(votes: VoteDescriptionResponse(yes: "100", no: "7", refrain: "50", abscent: "99"))
            .preferredColorScheme(.dark)
    }
}
