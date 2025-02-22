//
//  InboxRowView.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/16/23.
//

import SwiftUI

struct InboxRowView: View {
    let message: Message_ForNow
   
    @StateObject var viewModel = InboxViewModel()
    
    init(message: Message_ForNow) {
        self.message = message
        }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView( user: message.user, size: .medium )
               
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
               // make this value be updated by its own listener
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            HStack{
                Text(message.timeStampString)
                 Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            
        }
        .frame(height: 72)
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView(message: Message_ForNow.Mock_Messages[0])
    }
}
