import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State private var inputToken: String = "Bearer <Your Token>"
    @State private var storedToken: String = ""
    @State private var inArray: [Double] = []
    @State private var greeting: String = ""
    @State private var name: String = ""
    @State private var selectedTab: Int = 0
    @State private var topLinks: [DataModel.Data.top_links] = []
    @State private var recentLinks: [DataModel.Data.recent_links] = []
    @State private var chartd: [(String, Double)] = []
    
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        
           ZStack(alignment: .bottom) {
               
               VStack(spacing: 0) {
                   ScrollView {
                       HStack{
                           Text("Good morning, ")
                               .font(.title)
                               .foregroundColor(.gray)
                           Spacer()
                       }
                       
                              
                       HStack{
                           
                           Text("\(viewModel.userData.name)")
                               .font(.title)
                               .fontWeight(.bold)
                               .foregroundColor(.black)
                               .opacity(0.7)
                           Image("hand-wave")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 60, height: 60)
                                     
                                      
                           Spacer()
                           
                       }
                               
                           
                       //chart
                       if !inArray.isEmpty {
                       LineView(data: inArray,legend: "legendary")
                                                   .padding()
                                                   .frame(height: 400)
                                                   .padding(.bottom, -40)
                                           } else {
                                               Text("No data available")
                                                   .foregroundColor(.gray)
                                                   .padding()
                                           }
                       // scroll cards
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 15) {
                               AnalyticsCard(title: "Today's clicks", value: viewModel.analytics.totalClicks, iconName: "dot.circle.and.hand.point.up.left.fill")
                               AnalyticsCard(title: "Top Location", value: viewModel.analytics.location, iconName: "location")
                               AnalyticsCard(title: "Top Source", value: viewModel.analytics.source, iconName: "globe")
                           }
                           .padding(.horizontal)
                       }
                       .padding(.bottom)
                       HStack{
                           CardView2(icon: "growth", title: "View Analytics",  borderColor: Color.gray)
                       }.padding()
                      

                       // Picker for selecting different tabs
                       Picker(selection: $selectedTab, label: Text("Select a tab")) {
                           Text("Top Links").tag(0)
                           Text("Recent Links").tag(1)
                       }
                       .pickerStyle(SegmentedPickerStyle())
                       .padding()
                       
                       
                       
                      
                       if selectedTab == 0 {
                           ForEach(topLinks, id: \.url_id) { link in
                               LinkRow1(link: link)
                           }
                       } else {
                           ForEach(recentLinks, id: \.url_id) { link in
                               LinkRow2(link: link)
                           }
                       }
                       HStack{
                           CardView3(icon: "link-chain", title: "View all Links",  borderColor: Color.gray)
                       }.padding()
                           .padding(.top,3)
                     
                       
                       // Talk with Us Card
                       VStack {
                           CardView(icon: "phone.fill", title: "Talk with Us", backgroundColor: Color(.systemGreen), borderColor: Color.green)
                               .padding()

                           CardView(icon: "questionmark.circle.fill", title: "Frequently Asked Questions", backgroundColor: Color(.systemBlue), borderColor: Color.blue)
                               .padding()
                       }
                       
                   }
                   
                   .padding()
                  
                   
//                   Divider()
                   
                   // Bottom tab bar
                   HStack {
                       Spacer()
                       
                       TabBarButton(iconName: "link", title: "Links", isSelected: false) {
                           
                       }
                       
                       Spacer()
                       
                       TabBarButton(iconName: "square.grid.2x2.fill", title: "Courses", isSelected:false) {
                           
                       }
                       
                       Spacer()
                       
                       TabBarButton(iconName: "plus.circle.fill", title: "", isSelected: false) {
                           // Handle action when + button is tapped
                       }
                       
                       Spacer()
                       
                       TabBarButton(iconName: "megaphone.fill", title: "Campaigns", isSelected: false) {
                           
                       }
                       
                       Spacer()
                       
                       TabBarButton(iconName: "person.fill", title: "Profile", isSelected: false) {
                           
                       }
                       
                       Spacer()
                   }
                   .padding(10)
                   
                   .background(Color.white)
               }
               .onAppear {
                   fetchData()
                   saveText()
               }
               .edgesIgnoringSafeArea(.bottom)
               
           }
          
       }

    func fetchData() {
        DispatchQueue.main.async {
            greeting = getGreetingFromLocalTime()
            let token = retrieveToken()
            let apiCalls = [
                APICall(path: "api/v1/dashboardNew", queryItems: [
                ])
                // Add more API calls as needed
            ]
            
            
            
            
            
            let url = URL(string : apiCalls[0].endpoint)
            
            
            var request = URLRequest(url: url!)
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let myData = try decoder.decode(DataModel.self, from: data)
                        
                        // Access the properties of `myData` as needed
                        name = myData.support_whatsapp_number
                        topLinks = myData.data.top_links
                        recentLinks = myData.data.recent_links
                        if let dictionary = myData.data.overall_url_chart {
                            for (_, value) in dictionary {
                                self.inArray.append(Double(value))
                            }
                        } else {
                            //error handle
                        }
                        print(myData)
//                  ÷
                        
                    } catch {
                        print("Error: lol \(error)")
                    }
                }
            }.resume()
            
            // Moved outside of ContentView
            struct APICall: Identifiable, Hashable {
                let baseurl =  "https://api.inopenapp.com/"
                let id = UUID()
                let path: String
                let queryItems: [URLQueryItem]
                
                var endpoint: String {
                    var urlComponents = URLComponents(string: baseurl)!
                    urlComponents.path += path
                    //                urlComponents.queryItems = queryItems
                    
                    return urlComponents.string!
                }
            } }
    }
    


    func saveText() {
        UserDefaults.standard.set(inputToken, forKey: "storedToken")
    }

    func retrieveToken() -> String {
        if let storedToken = UserDefaults.standard.string(forKey: "storedToken") {
            self.storedToken = storedToken
            return storedToken
        } else {
            self.storedToken = "No text stored"
            return ""
        }
    }
   
}





 

