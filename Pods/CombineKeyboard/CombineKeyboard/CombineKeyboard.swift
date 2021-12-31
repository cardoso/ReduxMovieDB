//
//  CombineKeyboard.swift
//  CombineKeyboard
//
//  Created by 이병찬 on 2020/10/16.
//

import UIKit
import Foundation
import Combine

@available(iOS 13.0, *)
public class CombineKeyboard {
    public static let shared = CombineKeyboard()
    
    private let _frame: CurrentValueSubject<CGRect, Never>
    private var cancellables = Set<AnyCancellable>()
    
    /// A publisher emitting current keyboard `frame`
    /// You will be returned the current keyboard `frame` at start of subscription.
    public var frame: AnyPublisher<CGRect, Never> {
        _frame.removeDuplicates().eraseToAnyPublisher()
    }
    
    /// A publisher emitting current keyboard `height`
    /// You will be returned the current keyboard `height` at start of subscription.
    public var height: AnyPublisher<CGFloat, Never> {
        frame.map { UIScreen.main.bounds.height - $0.origin.y }.eraseToAnyPublisher()
    }
    
    /// A publisher emitting current keyboard `height` when keyboard's height is updated
    public var heightUpdated: AnyPublisher<CGFloat, Never> {
        height.dropFirst().eraseToAnyPublisher()
    }
    
    private init() {
        let defaultFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0)
        self._frame = .init(defaultFrame)
        
        /// MARK: Keyboard will change frame
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map { $0.keyboardFrame(defaultFrame) }
            .subscribe(_frame)
            .store(in: &cancellables)
        
        /// MARK: Keyboard will hide
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { $0.keyboardFrame(defaultFrame) }
            .subscribe(_frame)
            .store(in: &cancellables)
    }
}

fileprivate extension Notification {
    func keyboardFrame(_ defaultFrame: CGRect) -> CGRect {
        let value = self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        return value?.cgRectValue ?? defaultFrame
    }
}
