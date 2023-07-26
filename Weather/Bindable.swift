//
//  Bindable.swift
//  Weather
//
//  Created by Margarita Slesareva on 26.07.2023.
//

class Bindable<T> {
    typealias Listener = (T) -> Void
    
    var value: T? {
        didSet {
            guard let value else {
                return
            }
            
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        
        guard let value else {
            return
        }
        
        listener?(value)
    }
}
