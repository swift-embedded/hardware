

public protocol UART {
    /// Send given data over the UART interface with given timeout.
    func write(_ buffer: UnsafeBufferPointer<UInt8>, timeout: TimeInterval) throws

    /// Receive as much data as possible within a given time period.
    ///
    /// - Parameter buffer: The buffer to which the received data should be saved.
    ///                     Maximum number of received bytes is equal to the buffer's size.
    /// - Parameter timeout: After how much time the receiving should stop.
    /// - Returns: Number of bytes received and stored into `buffer`.
    func read(into buffer: UnsafeMutableBufferPointer<UInt8>, timeout: TimeInterval) throws -> Int
}

extension UART {
    /// Send given data over the UART interface.
    @inlinable
    public func write(_ data: [UInt8], timeout: TimeInterval = .seconds(5)) throws {
        try data.withUnsafeBufferPointer { buffer in
            try self.write(buffer, timeout: timeout)
        }
    }

    /// Receive up to `maximumLength` bytes over the UART interface.
    @inlinable
    public func read(maximumLength: Int, timeout: TimeInterval = .seconds(5)) throws -> [UInt8] {
        try [UInt8](unsafeUninitializedCapacity: maximumLength) { buffer, initializedLength in
            initializedLength = try self.read(into: buffer, timeout: timeout)
        }
    }
}

extension UART {
    /// Send given string over the UART interface.
    @inlinable
    public func write(_ str: String, timeout: TimeInterval = .seconds(5)) throws {
        var str = str // `withUTF8` requires the string to be mutable
        try str.withUTF8 { buffer in
            try write(buffer, timeout: timeout)
        }
    }
}

public struct UARTStream: TextOutputStream {
    public let uart: UART
    public var error: Error?

    public init(_ uart: UART) {
        self.uart = uart
    }

    public mutating func write(_ string: String) {
        do {
            try uart.write(string)
        } catch {
            self.error = error
        }
    }
}
