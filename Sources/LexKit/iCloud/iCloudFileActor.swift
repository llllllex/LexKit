//
//  iCloudFileActor.swift
//  
//
//  Created by Lex on 6/17/24.
//

import Foundation
import UniformTypeIdentifiers

public actor iCloudFileActor {
    
    public init() {
    }
    
    let coordinator = NSFileCoordinator()
    
    var filePresenters: [URL: FilePresenter] = [:]
}

private extension iCloudFileActor {
    
    private func containerURL() async -> URL? {
        
        let configuration = Configuration.shared
        if let iCloudContainerIdentifier = await configuration.parameterProvider?.iCloudContainerIdentifier {
            
            return FileManager.default
                .url(
                    forUbiquityContainerIdentifier: iCloudContainerIdentifier
                )
        }
        return nil
    }
    
    private func documentsURL() async -> URL? {
        
        await containerURL()?
            .appendingPathComponent(
                "Documents",
                conformingTo: .directory
            )
    }
}

private extension iCloudFileActor {
    
    private func startMonitoringFile(
        at url: URL
    ) {
        let presenter = FilePresenter(
            fileURL: url
        )
        filePresenters[url] = presenter
    }
    
    private func stopMonitoringFile(
        at url: URL
    ) {
        if let presenter = filePresenters[url] {
            NSFileCoordinator
                .removeFilePresenter(
                    presenter
                )
        }
        filePresenters[url] = nil
    }
}

private extension iCloudFileActor {
    
    /// 写入文件
    private func write(_ data: Data, to url: URL) throws {
        
        var coordinationError: NSError?
        var writeError: Error?
        
        coordinator.coordinate(
            writingItemAt: url,
            options: [.forDeleting],
            error: &coordinationError
        ) { coordinatedURL in
            
            do {
                
                try data.write(to: coordinatedURL, options: .atomic)
            } catch let error {
                
                writeError = error
            }
        }
        
        if let writeError {
            throw writeError
        }
        
        if let coordinationError {
            throw coordinationError
        }
    }
    
    /// 读取文件
    private func read(url: URL) throws -> Data {
        
        var coordinationError: NSError?
        var readData: Data?
        var readError: Error?
        
        let isAccessing = url.startAccessingSecurityScopedResource()
        coordinator.coordinate(
            readingItemAt: url,
            options: [],
            error: &coordinationError
        ) { coordinatedURL in
            
            do {
                readData = try Data(contentsOf: coordinatedURL)
            } catch let error {
                
                readError = error
            }
        }
        if isAccessing {
            url.stopAccessingSecurityScopedResource()
        }
        if let readError {
            throw readError
        }
        
        if let coordinationError {
            throw coordinationError
        }
        
        guard let readData else {
            throw NSError(
                domain: "CloudDocumentsError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "No data was read from the file."]
            )
        }
        
        return readData
    }
    
    private func delete(_ url: URL) throws {
        
        let isAccessing = url.startAccessingSecurityScopedResource()
        
        var coordinationError: NSError?
        var readError: Error?
        
        coordinator.coordinate(
            writingItemAt: url,
            options: [.forDeleting],
            error: &coordinationError
        ) { coordinatedURL in
            
            do {
                
                try FileManager.default.removeItem(at: coordinatedURL)
            } catch let error {
                
                readError = error
            }
        }
        if isAccessing {
            url.stopAccessingSecurityScopedResource()
        }
        
        if let readError {
            throw readError
        }
        
        if let coordinationError {
            throw coordinationError
        }
    }
}
