//
//  ShowDetailView.swift
//  MovieApp
//
//  Created by MAC on 16/08/22.
//

import SwiftUI

struct ShowDetailView: View {
    
    @EnvironmentObject var showModel: ShowModelView
    var show: Show
    
    var body: some View {
        ZStack { Color.gray.opacity(0.5).ignoresSafeArea()
        VStack {
            ScrollView {
                let url = URL(string: show.image.original)
                AsyncImage(url: url, content: {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(maxHeight: .infinity)
                        .mask(
                            LinearGradient(gradient: Gradient(stops: [
                                .init(color: Color.white, location: 0),
                                .init(color: Color.white, location: 0.8),
                                .init(color: Color.white.opacity(0), location: 1.0)]), startPoint: .top, endPoint: .bottom))
                }, placeholder: {
                    ProgressView()
                })
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("TV Series")
                        Text("·")
                            .font(.title2)
                            .bold()
                        Text(show.premiered)
                    }
                    Label("\(show.language)", systemImage: "text.bubble")
                }
                
                HStack{
                    ForEach(show.genres, id: \.self) { genre in
                        Text(genre)
                            .padding(7)
                            .background(RoundedRectangle(cornerRadius: .infinity).stroke())
                    }
                }
                .padding()
                
                Text(show.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                    .font(.body)
                    .bold()
                    .frame(width: 400, alignment: .leading)
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    Text("Rating: ")
                        .bold()
                    Label("", systemImage: "star.fill")
                        .foregroundColor(.yellow)
                    Text(" \(show.rating.average ?? 0.000, specifier: "%.1f") / 10")
                }
                .font(.title3)
                .padding()
                
                if(show.externals.imdb != nil) {
                    Link(destination: URL(string: "https://www.imdb.com/title/\(show.externals.imdb!)")!) {
                        Text("Watch on IMDB")
                            .font(.title2)
                            .padding(7)
                            .background(RoundedRectangle(cornerRadius: .infinity).stroke())
                    }
                }
                
            }
        }}
        .navigationTitle(show.name)
        .toolbar {
            Button {
                showModel.toggleFav(show: show)
            } label: {
                Label("", systemImage: showModel.isFav(show) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }
    }
}

/*
 struct ShowDetailView_Previews: PreviewProvider {
 static var previews: some View {
 ShowDetailView()
 }
 }
 */
