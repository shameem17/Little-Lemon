//
//  MenuItemGridView.swift
//  LittelLemon
//
//  Created by Shameem on 3/6/24.
//

import SwiftUI

let gridViewColumns: [GridItem] = [
    GridItem(.flexible(), spacing: nil),
    GridItem(.flexible(), spacing: nil),
    GridItem(.flexible(), spacing: nil)
]

struct MenuItemGridView: View {
    @ObservedObject var viewModel: MenuViewModel
    @State var forItem: MenuCategory
    var body: some View {
        LazyVGrid(columns: gridViewColumns,
                  content: {
        Section {
            ProductCard
        } header: {
            Text(forItem == .food ? "Food" : forItem == .drink ? "Drinks" : "Dessert")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        })
    }
}
extension MenuItemGridView{
    private var ProductCard: some View{
        ForEach(viewModel.items[forItem]!, id: \.id) { item in
            NavigationLink {
                MenuItemDetailsView(currentItem: item)
            } label: {
                VStack{
                    Image(item.image)
                        .resizable()
                        .frame(height: 180)
                    Text(item.title)
                        .foregroundStyle(.black)
                    Text("$\(item.price)")
                    RatingIndicator(currentRaing: item.ratings,
                                    size: 14)
                }
                .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    MenuItemGridView(viewModel: MenuViewModel(), forItem: .food)
}
