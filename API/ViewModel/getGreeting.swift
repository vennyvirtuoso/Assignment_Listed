//
//  fetchData.swift
//  API
//
//  Created by Vijendra Vaishya on 26/05/23.
//

import SwiftUI


func getGreetingFromLocalTime() -> String {

    let hour = Calendar.current.component(.hour, from: Date())
    
    if hour < 12 {
        return "Good Morning"
    } else if hour < 18 {
        return "Good Afternoon"
    } else {
        return "Good Evening"
    }
}


