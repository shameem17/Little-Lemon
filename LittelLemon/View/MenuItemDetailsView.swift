//
//  MenuItemDetailsView.swift
//  LittelLemon
//
//  Created by Shameem on 3/6/24.
//

import SwiftUI

struct MenuItemDetailsView: View {
    @State var currentItem: MenuItems
    @State var isLiked: Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                ProductImage
                    .padding(.bottom, 8)
                Capsule(style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(Color.gray.opacity(0.60))
                    .frame(maxWidth: 120, maxHeight: 5)
                VStack{
                    ProductPrice
                    
                    HStack{
                        ForEach(currentItem.ingredients, id: \.self) { ingredient in
                            Text("\(ingredient.rawValue)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    
                    ProductOrder
                    
                    RatingIndicator(currentRaing: currentItem.ratings, size: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Ingredients")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                    ProductIngredients
                    
                }
              
                .padding(.leading, 50)

                Spacer()
                Spacer()
            }
            
            .navigationTitle(currentItem.title)
        }
        .onAppear{
        }
    }
    
}

extension MenuItemDetailsView{
    private var ProductImage: some View{
        Image(currentItem.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 350)
            .shadow(radius: 15)
            .overlay(
                Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(.red)
                .frame(width: 40, height: 40)
                .offset(x: -15, y: 15)
                .padding(4)
                .onTapGesture {
                    isLiked.toggle()
                }
                .background(
                    Circle()
                        .fill(.white)
                        .shadow(radius: 10)
                        .offset(x: -15, y: 15)
                )
               , alignment: .topTrailing
            )
    }
    
    private var ProductPrice: some View{
        HStack{
            Text(currentItem.title)
                .font(.system(size: 24))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("$\(currentItem.price)")
                .font(.system(size: 24))
                .bold()
                .padding(.trailing)
                .foregroundStyle(Color.price)
            
        }
    }
    
    private var ProductOrder: some View{
        HStack{
            Text("Order:")
                .font(.system(size: 20))
            Text("\(currentItem.ordered)")
                .font(.title2)
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.black)
    }
    
    private var ProductIngredients: some View{
        VStack{
            ForEach(currentItem.ingredients, id: \.self) { ingredient in
                
                Text(". \(ingredient.rawValue)")
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    
            }
        }
    }
}


#Preview {
    
    MenuItemDetailsView(currentItem: MenuItems(title: "Food x",
                                       price: 67,
                                       image: "food3", ordered: 57, 
                                       ratings: 2.5,
                                       menuCategory: .food,
                                       ingredients: [.broccoli, .carrot]))
}
