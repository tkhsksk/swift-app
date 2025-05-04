//
//  PlaceDetailView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 11/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Combine

class SelectedPoint: ObservableObject {
    @Published var selectedIndex: Int = 0
}

struct PlaceDetailView : View {
    @Binding var isShowing: Bool
    @Binding var placeItem: ActivitiesPlaces?
    let defaultPoint = ActivitiesFamousPoints(
        id: 0,
        pointName: "Default",
        pointImage: "Default PlaceHolder",
        pointDescription: "Default Description PlaceHolder"
    )
    
    @ObservedObject var selectedPoint = SelectedPoint()
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Image(self.placeItem?.famousPointsArray[self.selectedPoint.selectedIndex].pointImage ?? "")
                    .resizable()
                    .frame(width: g.size.width, height: g.size.height)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .background(Color.black)
                    .onDisappear {
                        self.isShowing = false
                }
                
                VStack(alignment: .leading) {
                    Text(self.placeItem?.activityPlace ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .padding(.top, 34)
                        .padding(.leading, 30)
                    HStack{
                        Spacer()
                    }
                    
                    Spacer()
                    
//                    場所sheetのスライドの背景
                    PlacesDetail(placeItems: self.placeItem?.famousPointsArray[self.selectedPoint.selectedIndex] ?? self.defaultPoint)
                        .padding(.bottom, 50)
                    
                    ZStack {
                        BlurView(style: .light)
                            .frame(width: g.size.width, height: 130)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.placeItem?.famousPointsArray ?? [], id: \.id) { item in
                                    PlacesCircleView(placeItems: item, selectedPoint: self.selectedPoint)
                                }
                            }.frame(height: 130, alignment: .leading)
                                .padding(.leading, 8).padding(.trailing, 8)
                        }
                    }.padding(.bottom, 50)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// 場所sheetのスライド1つ
struct PlacesCircleView: View {
    var placeItems: ActivitiesFamousPoints
    @ObservedObject var selectedPoint: SelectedPoint
    
    var body: some View {
        Button(action: {
            self.selectedPoint.selectedIndex = self.placeItems.id
        }) {
            ZStack {
//                アクティブになった場合
                if self.selectedPoint.selectedIndex == self.placeItems.id {
//                    Text("✓")
//                        .font(.system(size: 30, weight: .bold))
//                        .foregroundColor(.white)
                    Image(self.placeItems.pointImage)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 110, height: 110)
                        .background(Color.black)
                        .cornerRadius(4)
                        .opacity(1)
//                アクティブじゃない場合
                } else {
                    Image(self.placeItems.pointImage)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 110, height: 110)
                        .background(Color.black)
                        .cornerRadius(4)
                        .opacity(0.4)
                }
            }
        }
//        .padding(.horizontal, 8)
    }
}

// 場所sheetのテキスト
struct PlacesDetail: View {
    var placeItems: ActivitiesFamousPoints
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeItems.pointName)
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.leading, 30)
            
            Text(placeItems.pointDescription)
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .regular, design: .default))
                .padding(.leading, 30)
                .padding(.trailing, 30)
        }
    }
}
