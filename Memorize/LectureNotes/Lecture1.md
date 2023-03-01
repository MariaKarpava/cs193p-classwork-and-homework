// 1
Lego analogy of different kinds of Views:
 
 Views are kind of legos. Lego house is actually build from other lego blocks (kitchen, bedroom...), kitchen (cupboard, sink..). So if you wanna behave like a view, you are gonna provide a body variable that is of some other view.
 
 Lego combiners can combine lego blocks making complicated interfaces.
 Combiner Views - take other Views and combine them on the screen (either arrange them in a greed, or may be stack on top of each other..).
 
 Bag of lego (ViewBuilder function) - usually when you open it, it is packed in different little plastic bags, you don't have to search through thousands of pieces to build a tower, for example. There is a bag with tower pieces.


// 2
 struct ContentView: View { }
     We created a data structure that behaves like a View.
     A View is a rectangular area on screen.
     We can put Views together to build complicated interfaces.
     To use it we should implement a body variable that of type some View.
     The value of this body variable is calculated by executing this {} function.
     VStack, HStack -- are view builders.




// 3
 - HStack uses the all the space it can in both directions. That is why we
    had tall and wide cards.
 
 - LazyVGrid uses all the width horizontally for its columns, but
    vertically it would make cards as small as possible.
 
 
 Spacer() also works differently:
     - The HStack was using all the vertical space. So spacers used only
     tiny sliver of space between our buttons at the bottom.
 
     - The LazyVGrid doesn't use all the vertical space and so the spacer has
     taken up all the space in between. They tale any open spaces availlable
     that no one else wants.
 


// 4
 ForEach creates a View for each of the things in an array.
     This array has to contain things that are identifiable so that the
     ForEach can keep track of which things in an array match which of
     the Views it is creating. It normally does this by requiring thing
     in the array to behave like identifiable. Strings can not behave
     like identifiable because they can look exactly the same, but they might
     be different strings. We can achieve this by having id: \.self argument
     that forces ForEach to think that each of the strings was itself
     identifiable, and then we make sure to never put the same string in
     our array twice.
 
 ForEach(vehicleArray[0..<vehicleCount], id: \.self, content: { emoji in
     CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
 })
 
 Lazy in LazyVGrid: LazyVGrid is lazy about accessing the body vars of all of its Views. We only get the value of the body var in a LazyVGrid for Views that actually appear on screen. This LazyVGrid could scale to having thousands of cards because in general creating Views is really lightweight. But accessing a View's body is another story. That's going to create a whole bunch of other Views and potentially cause their body vars to get accessed. So there is a lot of infrastructure in SwiftUI to access the View's body var when absolutely necessary.



// 5
 All views in SWiftUI are immutable! When things on the screen are being changed, the
     entire UI is being rebuild. Fot that reason, we use @State for now in front of var.
     This var is still immutable. It just changes our var from being a boollean to a
     pointer to some boolean somewhere else in memory. That is where the value can change.
     So it is now just a pointer.



