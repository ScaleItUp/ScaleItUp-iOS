//
//  Dynamic.swift
//  Scale It Up!
//
//  Created by Arghadeep Chakraborty on 11/27/23.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    /// This function will set the passed closure to the listener.
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    /// didSet for the value, called with value changes
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    /// init for the value
    init(_ v: T) {
        value = v
    }
}
