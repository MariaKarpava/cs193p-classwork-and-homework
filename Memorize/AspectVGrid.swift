//
//  AspectVGid.swift
//  Memorize
//
//  Created by Maryia Karpava on 23/03/2023.
//

import SwiftUI

//ItemView is not a complete "dontcare", we know that it has to be a view
struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    // @escaping: this is a pointer to a function living in the heap
    init(items:[Item], aspectRatio: CGFloat,@ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                
                // Things in GeometryReader should be flexible in size - add VStack
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
            // I don't need a spacer, here I just need sth flexible to turn this flexible(VStack) so that the GeometryReader has sth flexible.
            Spacer(minLength: 0)
            
        }
    }
    
    
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        
        return gridItem
    }
    
    
    // written on assumption that there is no spacing between cards
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        
        return floor(size.width / CGFloat(columnCount))
    }
    
}







    //struct AspectVGrid_Previews: PreviewProvider {
    //    static var previews: some View {
    //        AspectVGrid()
    //    }
    //}
    

