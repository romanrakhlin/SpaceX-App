//
//  HeaderView.swift
//  SpaceX Rockets
//
//  Created by Roman Rakhlin on 3/18/22.
//

import SwiftUI

struct HeaderView: View {
    
    var imageURL: String
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? geometry.frame(in: .global).minY + UIScreen.main.bounds.height / 2.2 : UIScreen.main.bounds.height / 2.2)
                            .offset(y: -geometry.frame(in: .global).minY)
                 
                    case .failure(let error):
                        Image("no_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? geometry.frame(in: .global).minY + UIScreen.main.bounds.height / 2.2 : UIScreen.main.bounds.height / 2.2)
                            .offset(y: -geometry.frame(in: .global).minY)
                    case .empty:
                        Image("no_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? geometry.frame(in: .global).minY + UIScreen.main.bounds.height / 2.2 : UIScreen.main.bounds.height / 2.2)
                            .offset(y: -geometry.frame(in: .global).minY)
                 
                    @unknown default:
                        Image("no_image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: geometry.frame(in: .global).minY > 0 ? geometry.frame(in: .global).minY + UIScreen.main.bounds.height / 2.2 : UIScreen.main.bounds.height / 2.2)
                            .offset(y: -geometry.frame(in: .global).minY)
                }
            }
        }
        .frame(height: UIScreen.main.bounds.height / 3.8) // ditance between top and CardView
    }
}
