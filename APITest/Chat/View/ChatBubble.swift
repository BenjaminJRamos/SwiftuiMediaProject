//
//  ChatBubble.swift
//  APITest
//
//  Created by Benjamin  Ramos on 12/17/23.
//

import SwiftUI

struct ChatBubble: Shape {
    let isFromCurrentUser: Bool
    func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect,
                    byRoundingCorners: [.topLeft,
                                        .topRight,
                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                            ],
                    cornerRadii: CGSize(width: 16, height: 16))
        
                return Path(path.cgPath)
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(isFromCurrentUser: true)
    }
}
