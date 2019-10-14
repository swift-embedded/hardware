/// Provides access to I2C Master primitive operations.
public protocol I2CLowLevel {
    func start() throws
    func stop() throws
    func read(into buffer: UnsafeMutableBufferPointer<UInt8>, nack: Bool, timeout: TimeInterval) throws
    func write(_ buffer: UnsafeBufferPointer<UInt8>, timeout: TimeInterval) throws
}

/// Provides access to I2C Master standard transactions.
public protocol I2C {
    func read(address: Int, into buffer: UnsafeMutableBufferPointer<UInt8>, stop: Bool, timeout: TimeInterval) throws
    func write(address: Int, buffer: UnsafeBufferPointer<UInt8>, stop: Bool, timeout: TimeInterval) throws
}

/// Provides access to I2C Master memory transactions.
public protocol I2CMemory {
    func read(address: Int, register: UInt8, into buffer: UnsafeMutableBufferPointer<UInt8>, timeout: TimeInterval) throws
    func write(address: Int, register: UInt8, buffer: UnsafeBufferPointer<UInt8>, timeout: TimeInterval) throws
}

extension I2C {
    @inlinable
    public func read(address: Int, length: Int, stop: Bool = true, timeout: TimeInterval = .seconds(5)) throws -> [UInt8] {
        return try [UInt8](unsafeUninitializedCapacity: length) { buffer, initializedLength in
            try self.read(address: address, into: buffer, stop: stop, timeout: timeout)
            initializedLength = length
        }
    }

    @inlinable
    public func write(address: Int, data: [UInt8], stop: Bool = true, timeout: TimeInterval = .seconds(5)) throws {
        try data.withUnsafeBufferPointer { buffer in
            try self.write(address: address, buffer: buffer, stop: stop, timeout: timeout)
        }
    }
}

extension I2CMemory {
    @inlinable
    public func read(address: Int, register: UInt8, length: Int, timeout: TimeInterval = .seconds(5)) throws -> [UInt8] {
        return try [UInt8](unsafeUninitializedCapacity: length) { buffer, initializedLength in
            try self.read(address: address, register: register, into: buffer, timeout: timeout)
            initializedLength = length
        }
    }

    @inlinable
    public func write(address: Int, register: UInt8, data: [UInt8], timeout: TimeInterval = .seconds(5)) throws {
        try data.withUnsafeBufferPointer { buffer in
            try self.write(address: address, register: register, buffer: buffer, timeout: timeout)
        }
    }
}
