//
//  LineChart.swift
//  API
//
//  Created by Vijendra Vaishya on 12/04/24.
//

import Foundation
import SwiftUI
import SwiftUICharts
struct CardsCollection: View {
    

    var body: some View {
        VStack{
            
        }
    }
}

struct AnalyticsCard: View {
    let title: String
    let value: Any
    let iconName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: iconName) 
                .font(.system(size: 24))
                .foregroundColor(.blue)
            Text("\(formattedValue)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.brown)
                .lineLimit(1)
        }
        .padding(5)
        .frame(width: 120, height: 120)
        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }

    var formattedValue: String {
        if let intValue = value as? Int {
            return "\(intValue)"
        } else if let stringValue = value as? String {
            return stringValue
        } else {
            return "Unknown"
        }
    }
}






struct LinkRow1: View {
    let link: DataModel.Data.top_links

    var body: some View {
        LinkCardView(iconName: "Amazon_icon", title: link.title, totalClicks: link.total_clicks, linkOpen:link.web_link)
    }
}

struct LinkRow2: View {
    let link: DataModel.Data.recent_links

    var body: some View {
        LinkCardView(iconName: "Amazon_icon", title: link.title, totalClicks: link.total_clicks, linkOpen:link.web_link)
    }
}





struct LinkCardView: View {
    let iconName: String
    let title: String
    let totalClicks: Int
    let linkOpen: String
    
    @State private var isLinkClicked: Bool = false
    @State private var showCopiedAlert: Bool = false
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding(.top,20)
                        .padding(.horizontal,20)
                        .shadow(radius: 5)
                    
                    Text(title)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Total Clicks:")
                    Text("\(totalClicks)")
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Button(action: {
                    isLinkClicked = true
                }) {
                    HStack {
                        Image(systemName: "link")
                            .foregroundColor(.blue)
                        Text(linkOpen)
                            .foregroundColor(.blue)
                            .font(.footnote)
                            .padding(.leading, 4)
                    }
                }
                .padding([.horizontal, .vertical], 10)
                
                Spacer()
                
                Button(action: {
                    // Copy link to clipboard
                    UIPasteboard.general.string = linkOpen
                    showCopiedAlert = true
                }) {
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(.blue)
                }
                .alert(isPresented: $showCopiedAlert) {
                            Alert(title: Text("Copied"))
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 1)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [3]))
                    .padding(.horizontal,-4)
            )
            .background(Color.blue.opacity(0.1).frame(maxWidth: .infinity))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding(.horizontal, 5)
    }
}








struct CardView: View {
    var icon: String
    var title: String
    var backgroundColor: Color
    var borderColor: Color
    
    let cardHeight: CGFloat = 30
    let titleFontSize: CGFloat = 15

    var body: some View {
        HStack(spacing: 0) { // Setting spacing to 0
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(icon == "chart.bar.fill" ? .gray : backgroundColor) 
                .padding()
            
            
                Text(title)
                    .font(.system(size: titleFontSize))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center) // Center the text horizontally
            
            .frame(maxWidth: .infinity)
            Spacer()
            Spacer()
            Spacer() 
            Spacer()
            Spacer()
            
        }
        .frame(maxWidth: .infinity, minHeight: cardHeight)
        .background(backgroundColor.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 2)
        )
    }
}
struct CardView2: View {
    var icon: String
    var title: String
    
    var borderColor: Color
    
    let cardHeight: CGFloat = 30
    let titleFontSize: CGFloat = 15

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding()
                
                
            
            
                Text(title)
                    .font(.system(size: titleFontSize))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center) // Center the text horizontally
            
            Spacer()
            
        }
        .padding(.horizontal,60)
        .frame(maxWidth: .infinity, minHeight: cardHeight)
        
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 2)
        )
    }
}
struct CardView3: View {
    var icon: String
    var title: String
    
    var borderColor: Color
    
    let cardHeight: CGFloat = 30
    let titleFontSize: CGFloat = 15

    var body: some View {
        HStack(spacing: 0) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .padding()
            
            Text(title)
                .font(.system(size: titleFontSize))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            
        }
        .padding(.horizontal, 10) // Adjust horizontal padding
        .frame(maxWidth: .infinity, minHeight: cardHeight)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor.opacity(0.5), lineWidth: 2)
        )
    }
}

struct TabBarButton: View {
    let iconName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: iconName)
                    .font(.system(size: iconName == "plus.circle.fill" ? 30 : 20))
                    .foregroundColor( .white)
                    .padding(8)
                    .background(LinearGradient(gradient: Gradient(colors: [isHovered ? .green : .blue, isHovered ? .blue : .green]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .scaleEffect(isHovered ? 1.2 : 1)
                            .opacity(isHovered ? 0 : 1)
                            
                    )
                    
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    
            }
            .padding(.vertical, 8)
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




