//
//  AccountView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 08/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    @State var notificationToggle: Bool = false
    @State var locationUsage: Bool = false
    @State var username: String = "James"
    @State var selectedCurrency: Int = 0
    @State var currencyArray: [String] = ["$ US Dollar", "£ GBP", "€ Euro"]
    
    @State var selectedPaymentMethod: Int = 1
    @State var paymentMethodArray: [String] = ["Paypal", "Credit/Debit Card", "Bitcoin"]
    
    var body: some View {
        GeometryReader { g in
            VStack {
                Image("italy")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                
                if viewModel.isLoading {
                    ProgressView("読み込み中…")
                } else if let profile = viewModel.profile {
                    Text(profile.name)
                        .font(.system(size: 20))
                }
                    
                Form {
                    
                    Section(header: Text("Payment Settings")) {
                        Picker(selection: self.$selectedCurrency, label: Text("Currency")) {
                            ForEach(0 ..< self.currencyArray.count) {
                                Text(self.currencyArray[$0]).tag($0)
                            }
                        }
                        
                        Picker(selection: self.$selectedPaymentMethod, label: Text("Payment Method")) {
                            ForEach(0 ..< self.paymentMethodArray.count) {
                                Text(self.paymentMethodArray[$0]).tag($0)
                            }
                        }
                        Button(action: {
                            print("Button tapped")
                        }) {
                            
                            if (self.paymentMethodArray[self.selectedPaymentMethod]) == "Credit/Debit Card" {
                                Text("Add a Credit/Debit Card to your account")
                                
                            } else {
                                Text("Connect \(self.paymentMethodArray[self.selectedPaymentMethod]) to your account")
                            }
                        }

                    }
                    Section(header: Text("アカウント設定")) {
                        NavigationLink(destination: AccountDetailView()) {
                            Text("プロフィール設定")
                        }
                       
                        NavigationLink(destination: Text("Billing Info")) {
                            Text("Billing Information")
                        }
                    }
                    
                    Section(footer: Text("Allow push notifications to get latest travel and equipment deals")) {
                        Toggle(isOn: self.$locationUsage) {
                            Text("Location Usage")
                        }
                        Toggle(isOn: self.$notificationToggle) {
                            Text("Notifications")
                        }
                    }
                        
            }
            .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            .navigationBarTitle("Settings")
            .onAppear {
                viewModel.loadProfile()
            }
         }
        }
    }
 }

