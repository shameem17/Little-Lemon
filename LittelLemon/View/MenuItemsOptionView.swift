//
//  MenuItemsOptionView.swift
//  LittelLemon
//
//  Created by Shameem on 3/6/24.
//

import SwiftUI

struct MenuItemsOptionView: View {
    @ObservedObject var viewModel = MenuViewModel()
    var body: some View {
        NavigationStack{
            List{
                Section("select category"){
                    Toggle("Food", isOn: $viewModel.isFoodShown)
                    Toggle("Drinks", isOn: $viewModel.isDrinkShown)
                    Toggle("Dessert", isOn: $viewModel.isDessertShown)
                }
                
                Picker("sort by", selection: $viewModel.sortingCategory) {
                    ForEach(SortingCategory.allCases, id: \.self) { sortCategory in
                        Text(sortCategory.rawValue).tag(sortCategory)
                    }
                }
            }
            .pickerStyle(.inline)
            .listStyle(.automatic)
            
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(content: {
                ToolbarItem {
                    Button(action: {
                        self.viewModel.showFilter.toggle()
                        self.viewModel.sortingHandler()
                    }, label: {
                        Text("Done")
                    })
                }
            }
            )
        }
       
    }
}





#Preview {
    MenuItemsOptionView()
}
