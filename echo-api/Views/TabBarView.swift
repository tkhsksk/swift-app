//
//  TabBarView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 02/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            NavigationView {
                ActivitiesContentView(activtiesData: Activities(
                    data: ActivitiesMockStore.activityData,
                    items: ActivitiesMockStore.activities
                ))
            }
            .tag(0)
            .tabItem {
                Image("icon-activity")
                    .resizable()
                Text("Activities")
            }
            
            NavigationView {
                ActivitiesCartView(ShoppingCartItemsData: ActivitiesCart(
                    data: ActivitiesMockStore.shoppingCartData
                ))
            }
            .tag(1)
            .tabItem {
                Image("icon-cart")
                Text("Cart")
            }
            
            NavigationView {
                     AccountView()
                  }
                   .tag(2)
                    .tabItem {
                    Image("icon-profile")
                    Text("Account")
                }
        }
    }
}



