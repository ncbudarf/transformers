//
//  BuildView.swift
//  transformers
//
//  Created by Noah budarf on 2020-06-23.
//  Copyright © 2020 Noah budarf. All rights reserved.
//

import SwiftUI

struct BuildView: View {
    @ObservedObject var viewModel: BuildViewModel = BuildViewModel()
    
    private func factionSelection() {
        
    }
    
    private func rerollRobot() {
        
    }
    
    private func submitRobot() {
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView( .vertical) {
                VStack() {
                    HStack {
                        Button(action: self.factionSelection) {
                            Image("autobotButtonIcon")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.red)
                                .padding()
                        }.padding()
                        Button(action: self.factionSelection) {
                            Image("decepticonButtonIcon")
                                .resizable()
                                .foregroundColor(Color.purple)
                                .scaledToFit().padding()
                        }.padding()
                    }.frame(width: geometry.size.width, height: 150)
                    
                    ZStack {
                        PieChartView(pieChart: self.viewModel.pieChart)
                            .frame(width: geometry.size.width/1.5, height: geometry.size.width/1.5)
                        
                        Text(self.viewModel.totalPowerText())
                            .font(Font.system(size:30))
                            .frame(width: geometry.size.width, height: geometry.size.width/1.5, alignment: .bottom)
                            .foregroundColor(.purple)//TODO: color should change on faction selection
                    }
            
                    HStack {
                        Button(action: self.rerollRobot) {
                            Text(self.viewModel.reRollButtonText())
                                .font(Font.system(size:25))
                                .fontWeight(.bold)
                                .padding()
                                .font(.title)
                                .foregroundColor(.purple)//TODO: color should change on faction selection
                        }.padding()
                        
                        Button(action: self.submitRobot) {
                            Text(self.viewModel.submitButtonText())
                                .font(Font.system(size:25))
                                .fontWeight(.bold)
                                .padding()
                                .font(.title)
                                .foregroundColor(.purple)//TODO: color should change on faction selection
                        }.padding()
                        
                    }.frame(width: geometry.size.width, height: 50)
                }
            }
        }
    }
}

struct StatView: View {
    var statViewModel: StatViewModel
    
    var body: some View {
        HStack {
            Text("\(statViewModel.statName):").padding()
            ZStack {
                Rectangle()
                    .fill(statViewModel.statColor)
                    .frame(width: 25, height: 25)
                Text(String(statViewModel.statValue)).padding()
            }
        }
    }
}

struct StatViewModel {
    let statName: String
    var statValue: Int
    var statColor: Color
    
    init(statName: String, statValue: Int, statColor: Color) {
        self.statName = statName
        self.statValue = statValue
        self.statColor = statColor
    }
}
