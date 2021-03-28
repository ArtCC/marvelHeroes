//
//  Presenter.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import Foundation

/// Base module interface where we will know the state of the view so we will do the stuff needed.
protocol Presenter: class {
  
  /// Handle UI status updates to take some actions.
  ///
  /// - Parameter status: current UI status (based on iOS view life cycle).
  func viewDidUpdate(status: ViewStatus)
}

/// Enum to know the status for the view (based on view controller life cycle)
///
/// - didLoad: view did load life cycle event
/// - willAppear: view will appear life cycle event
/// - didAppear: did appear life cycle event
/// - willDisappear: will disappear life cycle event
/// - didDisappear: did disappear life cycle event
enum ViewStatus: Int {
  
  case didLoad, willAppear, didAppear, willDisappear, didDisappear
  
  init() {
    
    self = .didLoad
  }
}
