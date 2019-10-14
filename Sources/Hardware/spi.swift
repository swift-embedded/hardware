public protocol SPI {
    func send(_ buffer: UnsafeBufferPointer<UInt8>, timeout: TimeInterval) throws
    // TODO: receive
}

extension SPI {
    @inlinable
    public func send(_ data: [UInt8], timeout: TimeInterval = .seconds(5)) throws {
        try data.withUnsafeBufferPointer { buffer in
            try self.send(buffer, timeout: timeout)
        }
    }
}
