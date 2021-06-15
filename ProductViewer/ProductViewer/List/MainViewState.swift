//
//  MainViewState.swift
//  ProductViewer
//
//  Created by Harikrushna Sahu on 13/06/21.
//  Copyright © 2021 Target. All rights reserved.
//

import Tempo

enum ApiFetch: Equatable {
    case ready
    case fetching
    case fetched
}

struct MainViewState: TempoViewState {
    var viewStatus: ApiFetch = .ready
}
    
func ==(lhs: MainViewState, rhs: MainViewState) -> Bool {
    return lhs.viewStatus == rhs.viewStatus
}
