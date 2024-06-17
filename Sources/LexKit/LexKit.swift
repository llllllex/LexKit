// The Swift Programming Language
// https://docs.swift.org/swift-book



/// Describing all parameters the Package needs to provide associated functions.
public protocol ParameterProvider: Sendable {
    
    
    /// Provide the iCloud container's identifier if there's needs for iCloud storage.
    var iCloudContainerIdentifier: String? { get }
}


/// Describing all configurations for this package.
public class Configuration {
    
    /// All pre-provide parameters by host project which use this package.
    ///
    /// Functions in this package will found all those parameters in this instance.
    public static var parameterProvider: ParameterProvider?
}
