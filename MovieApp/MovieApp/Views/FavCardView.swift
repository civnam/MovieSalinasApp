//
//  FavCardView.swift
//  MovieApp
//
//  Created by MAC on 17/08/22.
//

import SwiftUI

struct FavCardView: View {
    
    @EnvironmentObject var showModel: ShowModelView
    var show: Show
    @State private var wantDelete = false
    @State private var confirmDelete = false
    
    var body: some View {
        let url = URL(string: show.image.original)
        VStack {
            NavigationLink(destination: ShowDetailView(show: show)) {
                AsyncImage(url: url, content: {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .contextMenu{
                            Label("Every \(show.schedule.days[0]) at \(show.schedule.time)", systemImage: "clock")
                        }
                }, placeholder: {
                    ProgressView()
                })
            }
            Button {
                if showModel.isFav(show) {
                    wantDelete = true
                } else {
                    showModel.makeFav(show: show)
                }
            } label: {
                Label("", systemImage: "heart.fill")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
                    .background(Color.purple.opacity(0))
            }
            Spacer()
        }
        .background(Color.purple.opacity(0.4))
        .cornerRadius(20)
        .alert(isPresented: $wantDelete) {
            Alert(title: Text("Confirmation"),
                  message: Text("Are you sure?"),
                  primaryButton: .default(Text("Accept"), action: { showModel.undoFav(show: show) }),
                  secondaryButton: .destructive(Text("Cancel")))
        }
    }
}

/*
struct FavCardView_Previews: PreviewProvider {
    static var previews: some View {
        FavCardView()
    }
}
*/
