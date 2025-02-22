//
//  placeholder.swift
//  APITest
//
//  Created by Benjamin  Ramos on 11/24/23.
//

import SwiftUI

struct notificationView: View {
    @StateObject var viewModel: notificationViewModel
    @State var badgeManager = AppAlertBadgeManager(application: UIApplication.shared)
    
    init(user:User_fornow) {
        self._viewModel = StateObject(wrappedValue: notificationViewModel(user: user))
    }
    
    var body: some View {
        
        ZStack {
            
            NavigationStack {
      
            ScrollView {
                LazyVStack {
                    
                    // NOTIFICATIONS PRINT HERE
                    ForEach(viewModel.notifications) {
                        notis in
                        notificationCell(noti: notis)
                        
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .navigationTitle("Notifications")
        }
            
                .frame(maxHeight: .infinity, alignment: .bottom)
                .onAppear {
                    viewModel.addListenerForNoti()
                    badgeManager.resetAlertBadgetNumber()
            }
        }
    }
}

struct notificationView_Previews: PreviewProvider {
    static var previews: some View {
        notificationView(user: User_fornow.Mock_USERS[0])
    }
}
