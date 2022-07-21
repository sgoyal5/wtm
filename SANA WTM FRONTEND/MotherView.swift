//
//  MotherView.swift
//  wtm!
//
//  Created by Sana Goyal on 7/20/22.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .page1:
            edit_profile()
        case .page2:
            profile_upcoming()
        case .page3:
            profile_invitations()
        case .page4:
            create_event()
        case .page5:
            manage_event()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

