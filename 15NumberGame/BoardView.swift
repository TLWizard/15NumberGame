//
//  BoardView.swift
//  15NumberGame
//
//  Created by Tushar Lanka on 5/19/25.
//

import Foundation
import SwiftUI

struct BoardView: View {
    
    var body: some View {
        
        ZStack{
            Rectangle().fill(Color(.red))
                .ignoresSafeArea()
            
            Board()
           
            
        }
       
    }
}

#Preview{
    BoardView()
}
