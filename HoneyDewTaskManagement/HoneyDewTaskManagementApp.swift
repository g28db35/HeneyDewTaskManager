//
//  HoneyDewTaskManagementApp.swift
//  HoneyDewTaskManagement
//
//  Created by Randy Chang on 11/24/24.
//

import SwiftUI

@main
struct HoneyDewTaskManagementApp: App {
    var body: some Scene {
        WindowGroup {
           MainTabView()
        }
        .modelContainer(for: Task.self)
    }
   
}

struct MainTabView: View {
    // Track the onboarding screen state and only show once
    @AppStorage("isOnboardingScreenShowing") var isOnboardingScreenShowing = true
    
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Label("HoneyDew Tasks", systemImage: "list.bullet")
                }
            
            InspirationQuoteView()
                .tabItem {
                    Label("HoneyDew Quote", systemImage: "heart.fill")
                }
        }
        .sheet(isPresented: $isOnboardingScreenShowing) {
            OnboardingView(isOnboardingScreenShowing: $isOnboardingScreenShowing)
            
        }
    }
}

/* Capstone Requirement 2 - Onboarding screens
   Define 3 sliding pages to provide one liner description of the app and two key features
 */
struct PageInfo: Identifiable {
    let id = UUID()
    let label: String
    let text: String
    let image: ImageResource
}

let pageInfo: [PageInfo] = [
    .init(label: "Welcome", text: "Welcome to HoneyDew Task Management App!", image: .welcome1 ),
    .init(label: "Task List", text: "Manage your chores to keep your significant other happy!", image: .welcome2),
    .init(label: "Daily Inspiration Quote", text: "To keep your tasks organized, you need to keep your mind focused and motivated", image: .welcome3 )
]

struct OnboardingView: View {
    @Binding var isOnboardingScreenShowing: Bool
    var body: some View {
        VStack {
            TabView {
                ForEach(pageInfo) { page in
                    VStack {
                        Text(page.label)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text(page.text)
                            .fontWeight(.medium)
                            .padding()
                        
                        Image(page.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    
                }
            }
            
            Button {
                isOnboardingScreenShowing.toggle()
            } label: {
                Text("Got it")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(width : 300)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            }
            .interactiveDismissDisabled()
            .tabViewStyle(.page)
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .label
                UIPageControl.appearance().pageIndicatorTintColor = .systemGray
            }
        }
    }
