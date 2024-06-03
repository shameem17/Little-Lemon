//
//  ViewModel.swift
//  LittelLemon
//
//  Created by Shameem on 2/6/24.
//

import Foundation

//protocol
protocol MenuItemProtocol{
    var title: String { get }
    var price: Int { get }
    var image: String { get }
    var ordered: Int { get set }
    var ratings: Double { get set }
    var menuCategory: MenuCategory { get }
    var ingredients: [Ingredient] { get }
}

//struct MenuItems confirms to MenuItemProtocol protocol
struct MenuItems: MenuItemProtocol, Identifiable{
    let id = UUID()
    let title: String
    let price: Int
    let image: String
    var ordered: Int
    var ratings: Double
    let menuCategory: MenuCategory
    let ingredients: [Ingredient]
}

//viewModel
final class MenuViewModel: ObservableObject{
    @Published var items: [MenuCategory: [MenuItems]] = [:]
    @Published var foods: [MenuItems] = []
    @Published var drinks: [MenuItems] = []
    @Published var desserts: [MenuItems] = []
    @Published var showFilter: Bool = false
    @Published var isFoodShown: Bool = true
    @Published var isDrinkShown: Bool = true
    @Published var isDessertShown: Bool = true
    @Published var sortingCategory: SortingCategory = .name
    
    
    init(){
        //initialize using loop
        for index in 0..<12{
            self.foods.append(MenuItems(title: "Food \(index + 1)",
                                        price: Int.random(in: 100...1000), //generate random price
                                        image: "food\(index%6)",
                                        ordered: Int.random(in: 0...1000),
                                        ratings: Double.random(in: 1...5),
                                        menuCategory: .food,
                                        ingredients: [.broccoli, .carrot, .pasta, .spinach]))
        }
      

        
        for index in 0..<8{
            self.drinks.append(MenuItems(title: "Drink \(index+1)",
                                         price: Int.random(in: 10...150),
                                         image: "drinks\(index%2)",
                                         ordered: Int.random(in: 0...1200),
                                         ratings: Double.random(in: 1...5),
                                         menuCategory: .drink,
                                         ingredients: [.spinach, .pasta]))
        }
        
        for index in 0..<4{
            self.desserts.append(MenuItems(title: "Dessert \(index+1)",
                                           price: Int.random(in: 15...180) ,
                                           image: "food\(index%3)",
                                           ordered: Int.random(in: 0...340),
                                           ratings: Double.random(in: 1...5),
                                           menuCategory: .food,
                                           ingredients: [.tomatoSauce, .pasta]))
        }
        
        //merge the menu items into one array
        self.items[MenuCategory.food] =  self.foods
        self.items[MenuCategory.drink] = self.drinks
        self.items[MenuCategory.dessert] = self.desserts
    }
    
    func sortingHandler(){
        switch self.sortingCategory{
        case .mostPopular:
            sortByPopularity()
        case .price:
            sortByPrice()
        case .name:
            sortByName()
        }
    }
    
   private func sortByPrice(){
        self.items[.food] = self.items[MenuCategory.food]!.sorted { $0.price < $1.price }
        self.items[.drink] = self.items[MenuCategory.drink]!.sorted { $0.price < $1.price }
        self.items[.dessert] = self.items[MenuCategory.dessert]!.sorted { $0.price < $1.price }
    }
    
   private func sortByName(){
        self.items[.food] = self.items[MenuCategory.food]!.sorted { $0.title < $1.title }
        self.items[.drink] = self.items[MenuCategory.drink]!.sorted { $0.title < $1.title }
        self.items[.dessert] = self.items[MenuCategory.dessert]!.sorted { $0.title < $1.title }
    }
    
    private func sortByPopularity(){
        self.items[.food] = self.items[MenuCategory.food]!.sorted { $0.ordered > $1.ordered }
        self.items[.drink] = self.items[MenuCategory.drink]!.sorted { $0.ordered > $1.ordered }
        self.items[.dessert] = self.items[MenuCategory.dessert]!.sorted { $0.ordered > $1.ordered }
    }
}
