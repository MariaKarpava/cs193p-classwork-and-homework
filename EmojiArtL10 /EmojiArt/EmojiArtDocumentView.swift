//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry))
                )
                .gesture(doubleTapToZoom(in: geometry.size).exclusively(before: deselectAllEmojisGesture()))
                
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    // these are emojis that I dropped on background
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
                            .font(.system(size: fontSize(for: emoji)))
                            .background(selectedEmojis.containsEmoji(emoji) ? Rectangle().fill(Color.blue) : Rectangle().fill(Color.clear))
                        // when zoom in background image - emoji also zooms in
                            
                            .scaleEffect(zoomScale)
                            .position(position(for: emoji, in: geometry))
                        
                            .gesture(deleteEmojiGesture(emoji)
                                .exclusively(before: toggleEmojiGesture(emoji)
                                    .exclusively(before:
                                                    selectedEmojis.containsEmoji(emoji)
                                                        ? panEmojiGesture(for: emoji)
                                                        : nil
                                                )
                                )
                            )
                    }
                }
            }
            .clipped()
            .onDrop(of: [.plainText,.url,.image], isTargeted: nil) { providers, location in
                drop(providers: providers, at: location, in: geometry)
            }
            .gesture(panGesture().simultaneously(with: zoomGesture()))
        }
    }
    
    
    
    // MARK: - Select, deselect and delete Emoji
    
    @State private var selectedEmojis: Set<EmojiArtModel.Emoji> = Set()
    
    private func toggleEmojiGesture(_ emoji: EmojiArtModel.Emoji) -> some Gesture {
        return TapGesture()
            .onEnded {
                print("toggleEmojiGesture")
                selectedEmojis.toggleMembership(of: emoji) }
    }
    
    private func deselectAllEmojisGesture() -> some Gesture {
        return TapGesture()
            .onEnded { selectedEmojis.removeAll() }
    }
    
    private func deleteEmojiGesture(_ emoji: EmojiArtModel.Emoji) -> some Gesture {
        return TapGesture(count: 2)
            .onEnded { document.removeEmoji(emoji) }
    }
    
    
    // MARK: - Drag and Drop
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    // MARK: - Positioning/Sizing Emoji
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        let delta = selectedEmojis.containsEmoji(emoji) ? gestureEmojiPanOffset * zoomScale : CGSize.zero
        return convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry) + delta
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        let multiplier = selectedEmojis.containsEmoji(emoji) ? zoomEmojiScale : 1
        return CGFloat(emoji.size) * multiplier
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    
    // MARK: - Zooming
    
    // Zoom scale when Im not gesturing in a steady state of this app.
    // But I only want to do it in places where Im setting zoom scale, not where Im using it.
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    @GestureState private var gestureEmojiZoomScale: CGFloat = 1
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private var zoomEmojiScale: CGFloat {
        gestureEmojiZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        // Magnification gestures allows users to zoom in and pan the whole screen.
        
        // if set is empty - do current code
        // else - do sth different:
        //      change emojis size. onEnd - VM.cscaleEmoji for all emojis in set
        if selectedEmojis.isEmpty {
            return MagnificationGesture()
                .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                    gestureZoomScale = latestGestureScale
                }
            // gestureScaleAtEnd - how far the fingers are apart compared to what they started.
                .onEnded { gestureScaleAtEnd in
                    steadyStateZoomScale *= gestureScaleAtEnd
                }
        } else {
            return MagnificationGesture()
                .updating($gestureEmojiZoomScale) { latestGestureScale, gestureEmojiZoomScale, _ in
                    gestureEmojiZoomScale = latestGestureScale
                }
                .onEnded { gestureScaleAtEnd in
                    for emoji in selectedEmojis {
                        document.scaleEmoji(emoji, by: gestureScaleAtEnd)
                    }
                }
        }
        
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0  {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    // MARK: - Panning
    
    // Pan offset when I'm not gesturing.
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    
    // Only exists when gesture is going on, all other times it is 0.
    // It also can be a tuple or struct.
    // Every time sth changes(how far the finger has moved), we can update this value.
    // This is Delta of the offset (for ex. finger moved one pixel left and five pixels right).
    // Hence, this is not enough to calculate the position of the object.
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
   
    // But this IS enough to calculate the real-time position of the object even during a gesture.
    private var panOffset: CGSize {
        // you can find + function in the file with extensions
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
        
        // finalDragGestureValue - this is a value struct
        // var translation: CGSize - The total translation from the start of the drag gesture to the current event of the drag gesture.
        // (width and height since the start of the gesture)
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }
    


    @GestureState private var gestureEmojiPanOffset: CGSize = CGSize.zero
    
    private func panEmojiGesture(for emoji: EmojiArtModel.Emoji) -> some Gesture {
        DragGesture()
        // this is called repeatedly when fingers move
        // latestDragGestureValue - current info about fingers
        // gestureEmojiPanOffset - inout parameter that lets us modify @GestureState gestureEmojiPanOffset
            .updating($gestureEmojiPanOffset) { latestDragGestureValue, gestureEmojiPanOffset, _ in
                gestureEmojiPanOffset = latestDragGestureValue.translation / zoomScale
//                print("gestureEmojiPanOffset: \(gestureEmojiPanOffset)")
            }
            .onEnded { finalDragGestureValue in
                
                for emoji in selectedEmojis {
                    print("onEnd: document.moveEmoji \(emoji.text)")
                    document.moveEmoji(emoji, by: finalDragGestureValue.translation / zoomScale)
                }
            }
    }


    // MARK: - Palette
    
    var palette: some View {
        ScrollingEmojisView(emojis: testEmojis)
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testEmojis = "😀😷🦠💉👻👀🐶🌲🌎🌞🔥🍎⚽️🚗🚓🚲🛩🚁🚀🛸🏠⌚️🎁🗝🔐❤️⛔️❌❓✅⚠️🎶➕➖🏳️"
}

struct ScrollingEmojisView: View {
    let emojis: String

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}





