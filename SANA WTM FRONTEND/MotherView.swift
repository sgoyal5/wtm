//
//  MotherView.swift
//  wtm!
//
//  Created by Sana Goyal on 7/20/22.
//
//did this work
//testing push from tanvi testinggit branch
//testing push to remote

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .page1:
            profile_my_events()
        case .page2:
            profile_upcoming()
        case .page3:
            profile_invitations()
        case .page4:
            create_event()
        default: profile_my_events()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

