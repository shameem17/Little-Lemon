//
//  MenuItems.swift
//  LittelLemon
//
//  Created by Shameem on 2/6/24.
//

import SwiftUI



struct MenuItemView: View {
    @StateObject var viewModel: MenuViewModel = MenuViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                    
                    if self.viewModel.isFoodShown{
                        MenuItemGridView(viewModel: self.viewModel,
                                         forItem: .food)
                    }
                    if self.viewModel.isDrinkShown {
                        MenuItemGridView(viewModel: self.viewModel,
                                         forItem: .drink)
                    }
                    if self.viewModel.isDessertShown{
                        MenuItemGridView(viewModel: self.viewModel,
                                         forItem: .dessert)
                    }
                
            }
            .padding(.horizontal)
            .navigationTitle("Menu")
            .toolbar {
                ToolBarView
            }
        }
        .sheet(isPresented: self.$viewModel.showFilter, content: {
            MenuItemsOptionView(viewModel: self.viewModel)
        })
        
        .onAppear{
            self.viewModel.sortingHandler()
        }
        
    }
}


extension MenuItemView{
    private var ToolBarView: ToolbarItem<(), Button<Image>>{
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                self.viewModel.showFilter = true
            }, label: {
                Image(systemName: "slider.horizontal.3")
            })
        }
    }
    
}





struct RatingIndicator: View {
    @State var currentRaing: Double
    @State var size: CGFloat
    var body: some View {
        HStack(spacing: 1){
            ForEach(0..<5) { rating in
                Image(systemName: currentRaing >= Double(rating) ? "star.fill" : "star")
                    .font(.system(size: size))
                    .foregroundStyle(.orange)
            }
        }
    }
}



#Preview {
    MenuItemView()
}
