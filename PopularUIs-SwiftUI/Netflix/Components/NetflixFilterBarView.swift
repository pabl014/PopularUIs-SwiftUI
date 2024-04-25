//
//  NetflixFilterBarView.swift
//  PopularUIs-SwiftUI
//
//  Created by Paweł Rudnik on 25/04/2024.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false),
            FilterModel(title: "Categories", isDropdown: true)
        ]
    }
}


struct NetflixFilterBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockArray
    var selectedFilter: FilterModel? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                // we only want to show xmark if something is selected
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading)) // appears from the left
                        .padding(.leading, 16) // if x appears, it has leading padding of 16
                }
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropdown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16 : 0) // padding for the first FilterCell to the left, when nothing is selected
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}


fileprivate struct NetflixFilterBarPreview: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        NetflixFilterBarView(
            filters: filters,
            selectedFilter: selectedFilter,
            onFilterPressed: { newFilter in
                selectedFilter = newFilter
//                Task {
//                    try? await Task.sleep(nanoseconds: 1_000_000_000)
//                    selectedFilter = newFilter
//                }
            },
            onXMarkPressed: {
                selectedFilter = nil
            }
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        //NetflixFilterBarView()
            //.background(.red)
        NetflixFilterBarPreview()
    }
}
