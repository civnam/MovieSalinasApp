//
//  ShowRowView.swift
//  MovieApp
//
//  Created by MAC on 17/08/22.
//

import SwiftUI

struct ShowRowView: View {
    
    @EnvironmentObject var showModel: ShowModelView
    var show: Show
    @State private var wantDelete = false
    @State private var confirmDelete = false
    
    var body: some View {
        let url = URL(string: show.image.medium)
        HStack {
            AsyncImage(url: url, content: {image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
            }, placeholder: {
                ProgressView()
            })
            Text(show.name).bold()
            NavigationLink("", destination: ShowDetailView(show: show))
        } .swipeActions {
            Button {
                if showModel.isFav(show) {
                    wantDelete = true
                } else {
                    showModel.makeFav(show: show)
                }
            } label: {
                Label(showModel.isFav(show) ? "Delete" : "Favorite", systemImage: showModel.isFav(show) ? "trash.fill" : "heart")
                    .foregroundColor(Color.red)
            }.tint(showModel.isFav(show) ? .red : .green)
        }
        .alert(isPresented: $wantDelete) {
            Alert(title: Text("Confirmation"),
                  message: Text("Are you sure?"),
                  primaryButton: .default(Text("Accept"), action: { showModel.undoFav(show: show) }),
                  secondaryButton: .destructive(Text("Cancel")))
        }
    }
}

/*
struct ShowRowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowRowView()
    }
}
 */
