//
//  notificationCell .swift
//  APITest
//
//  Created by Benjamin  Ramos on 1/5/24.
//

import SwiftUI
import Kingfisher

struct notificationCell: View {
    let noti: Notification_ForNow
    
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        HStack {
            
            // IMAGE + USERNAME
                HStack{
                    if let user = noti.user {
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text(user.username ?? user.fullname ?? "user")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .sheet(isPresented: $showSheet) {
                    paymentView()
                }
            
            
           // TIMESTAMP:
            Text(noti.timeStampString)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
                .padding(.top, 1)
                .foregroundColor(.gray)
            
            // ACCEPT AND REJECT BUTTON
            
            HStack(spacing: 32) {
                Button {
                    showSheet.toggle()
                    print("accept and show payment screen")
                } label: {
                    Image(systemName: "checkmark.circle")
                }
                
                Button{
                    print("Reject and delete collection from firestore")
                } label: {
                    Image(systemName: "trash")
                        
                }
            }
            .padding()

            
        }
    }
}

#Preview {
    notificationCell(noti: Notification_ForNow.Mock_Notifications[0])
}
