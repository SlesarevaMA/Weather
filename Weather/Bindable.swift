//
//  Bindable.swift
//  Weather
//
//  Created by Margarita Slesareva on 26.07.2023.
//

class Bindable<T> {
  typealias Listener = (T) -> Void

  var value: T {
    didSet {
      listener?(value)
    }
  }
    
  private var listener: Listener?

  init(_ value: T) {
    self.value = value
  }
    
  func bind(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
    
}
