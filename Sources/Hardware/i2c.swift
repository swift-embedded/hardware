/// Provides access to I2C Master primitive operations.
public protocol I2CLowLevel {
    func start() throws
    func stop() throws
    func read(length: Int, nack: Bool) throws -> [UInt8]
    func write(_ data: [UInt8]) throws
}

/// Provides access to I2C Master standard transactions.
public protocol I2C {
    func read(address: Int, length: Int, stop: Bool) throws -> [UInt8]
    func write(address: Int, data: [UInt8], stop: Bool) throws
}

/// Provides access to I2C Master memory transactions.
public protocol I2CMemory {
    func read(address: Int, register: UInt8, length: Int) throws -> [UInt8]
    func write(address: Int, register: UInt8, data: [UInt8]) throws
}
