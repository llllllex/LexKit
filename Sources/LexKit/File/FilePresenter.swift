//
//  FilePresenter.swift
//  
//
//  Created by Lex on 6/17/24.
//

import Foundation

public final class FilePresenter: NSObject, NSFilePresenter {
    
    let fileURL: URL
    
    public var presentedItemOperationQueue: OperationQueue = .main
    
    public init(
        fileURL: URL,
        presentedItemOperationQueue: OperationQueue = .main
    ) {
        self.fileURL = fileURL
        self.presentedItemOperationQueue = presentedItemOperationQueue
        
        super.init()
        
        NSFileCoordinator
            .addFilePresenter(
                self
            )
    }
    
    deinit {
        NSFileCoordinator
            .removeFilePresenter(
                self
            )
    }
    
    public var presentedItemURL: URL? {
        return fileURL
    }
    
    public func presentedItemDidChange() {
        // 当文件发生变化时，执行相关操作
        // 例如，重新加载文件或通知其他组件
        print(
            "file changed"
        )
    }
}
