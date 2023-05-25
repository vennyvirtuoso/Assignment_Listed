//
//  DashboardViewModel.swift
//  API
//
//  Created by Vijendra Vaishya on 12/04/24.
//

import Foundation
class DashboardViewModel: ObservableObject {
    @Published var userData: UserData
    @Published var analytics: Analytics
    init(){
        userData = UserData(name: "Ajay Manva")
        analytics = Analytics(totalClicks: 123, location: "Ahmedabad", source: "Instagram")
    }
}
