//
//  BumbleHomeView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 19/04/2024.
//

import SwiftUI
import SwiftfulUI

struct BumbleHomeView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone" // it's going to save the state , that user is in: When user clicked on trending and then closes the app, reopens the app: AppStorage will take care of last selected filter
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffsets: [Int:Bool] = [:] // UserId : (Direction is Right: true , Left: false)
    @State private var currentSwipeOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 12) {
                header
                
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider(),
                        alignment: .bottom
                    )
                
                //BumbleCardView()
                
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                
                                let offsetValue = cardOffsets[user.id]
                                
                                userProfileCell(user: user, index: index)
                                    .zIndex(Double(allUsers.count - index)) // reverse Z index to get "previous" on top, "current" in the middle and "next" at the bottom
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndicators
                        .zIndex(99999) // making in on top, because .zIndex was previously changed
                }
                .frame(maxHeight: .infinity) // to avoid pushing navigation bar from the centre to the top while loading data
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        
        selectedIndex += 1
    }
    
    private func getData() async {
        
        guard allUsers.isEmpty else { return }
        
        do {
            allUsers = try await DatabaseHelper().getUsers()
            
        } catch {
            
        }
    }
    
    
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(6)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(6)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(6)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    
    private func userProfileCell(user: User, index: Int) -> some View {
        
        BumbleCardView(
            user: user,
            onSendAComplimentPressed: nil,
            onSuperLikePressed: nil,
            onXmarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPressed: {
                userDidSelect(index: index, isLike: true)
            },
            onHideAndReportPressed: {
                
            }
        )
        .withDragGesture(
            .horizontal,
            //                                        minimumDistance: 0,
            resets: true,
            rotationMultiplier: 1.05,
            scaleMultiplier: 0.8,
            onChanged: { dragOffset in
                // while we are dragging:
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in
                // when user lets go of the drag:
                
                // swiping to the left:
                if dragOffset.width < -80 {
                    userDidSelect(index: index, isLike: false)
                } else if dragOffset.width > 80 {
                    // swiping to the right:
                    userDidSelect(index: index, isLike: true)
                }
                //currentSwipeOffset = dragOffset.width
            }
        )
    }
    
    
    private var overlaySwipingIndicators: some View {
        
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay (
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0) // make it a little bit bigger during swiping
                .offset(x: min(-currentSwipeOffset, 150)) // if we drag to the left: it moves to the right, but not further than 150
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
                //.background(.green)
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay (
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0) // make it a little bit bigger during swiping
                .offset(x: max(-currentSwipeOffset, -150)) // if we drag to the right: it moves to the left, but not further than 150
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
                //.background(.green)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
}

#Preview {
    BumbleHomeView()
}


